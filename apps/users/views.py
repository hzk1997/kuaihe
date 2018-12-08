# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.http import response
from django.shortcuts import render,redirect
from django.views.generic import View
from django.core.urlresolvers import reverse
from users.models import User, Address
from django.contrib.auth import authenticate,login,logout
from django.http import HttpResponse
from utils.mixin import LoginRequiredMixin
from goods.models import GoodsSKU
from django_redis import get_redis_connection
import re

# Create your views here.
#/users/register
# def register(request):
#     '''显示注册界面'''
#     return render(request,'register.html')


class RegisterView(View):
    '''注册'''
    def get(self, request):
        '''显示注册页面'''
        return render(request, 'register.html')

    def post(self, request):
        '''进行注册处理'''
        # 接收数据
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        email = request.POST.get('email')
        allow = request.POST.get('allow')

        # 进行数据校验
        if not all([username, password, email]):
            # 数据不完整
            return render(request, 'register.html', {'errmsg': '数据不完整'})

        # 校验邮箱
        if not re.match(r'^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            return render(request, 'register.html', {'errmsg': '邮箱格式不正确'})

        if allow != 'on':
            return render(request, 'register.html', {'errmsg': '请同意协议'})

        # 校验用户名是否重复
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            # 用户名不存在
            user = None

        if user:
            # 用户名已存在
            return render(request, 'register.html', {'errmsg': '用户名已存在'})

        # 进行业务处理: 进行用户注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 1
        user.save()

        return redirect(reverse('goods:index'))

class LoginView(View):
    def get(self,request):
        '''显示登陆界面'''
        #判断是否记住用户名
        if 'username' in request.COOKIES:
            username = request.COOKIES.get('username')
            checked = 'checked'
        else:
            username = ''
            checked = ''
        return render(request,'login.html',{'username':username,'checked':checked})
    def post(self,request):
        '''登陆校验'''
        #接收数据
        username = request.POST.get('username')
        password = request.POST.get('pwd')
        #校验数据
        if not all([username, password]):
            return render(request,'login.html',{'errmsg':'数据不完整'})
        #业务处理：登陆校验
        user = authenticate(username=username, password=password)
        if user is not None:
            # A backend authenticated the credentials
            #记录用户登录状态
            login(request, user)

            # 获取登录后所要跳转到的地址
            # 默认跳转到首页
            next_url = request.GET.get('next', reverse('goods:index'))

            # 跳转到next_url
            response = redirect(next_url)  # HttpResponseRedirect

            #判断是否需要记住用户名
            remember = request.POST.get('remember')

            if remember == 'on':
                response.set_cookie('username', username,max_age=7*24*3600)
            else:
                response.delete_cookie('username')
            #返回response
            return response
            #跳转到首页
            return redirect(reverse('goods:index'))
        else:
            return render(request,'login.html',{'errmsg':'用户名或密码错误或未激活'})
    # No backend authenticated the credentials
        #返回应答

# /users/logout
class LogoutView(View):
    '''退出登录'''
    def get(self, request):
        '''退出登录'''
        # 清除用户的session信息
        logout(request)

        # 跳转到首页
        return redirect(reverse('goods:index'))

#users
class UserInfoView(LoginRequiredMixin, View):
    '''用户中心-信息页'''
    def get(self, request):
        '''显示'''
        # Django会给request对象添加一个属性request.user
        # 如果用户未登录->user是AnonymousUser类的一个实例对象
        # 如果用户登录->user是User类的一个实例对象
        # request.user.is_authenticated()

        # 获取用户的个人信息
        user = request.user
        address = Address.objects.get_default_address(user)

        # 获取用户的历史浏览记录
        # from redis import StrictRedis
        # sr = StrictRedis(host='172.16.179.130', port='6379', db=9)
        con = get_redis_connection('default')

        history_key = 'history_%d'%user.id

        # 获取用户最新浏览的5个商品的id
        sku_ids = con.lrange(history_key, 0, 4) # [2,3,1]

        # 从数据库中查询用户浏览的商品的具体信息
        # goods_li = GoodsSKU.objects.filter(id__in=sku_ids)
        #
        # goods_res = []
        # for a_id in sku_ids:
        #     for goods in goods_li:
        #         if a_id == goods.id:
        #             goods_res.append(goods)

        # 遍历获取用户浏览的商品信息
        goods_li = []
        for id in sku_ids:
            goods = GoodsSKU.objects.get(id=id)
            goods_li.append(goods)

        # 组织上下文
        context = {'page':'user',
                   'address':address,
                   'goods_li':goods_li}

        # 除了你给模板文件传递的模板变量之外，django框架会把request.user也传给模板文件
        return render(request, 'user_center_info.html', context)

#users/order
class UserOrderView(LoginRequiredMixin, View):
    '''用户中心订单页'''
    def get(self,request):
        '''显示'''
        # page = 'order'
        return render(request, 'user_center_order.html', {'page':'order'})

#users/address
class AddressView(LoginRequiredMixin, View):
    '''用户中心地址页'''
    def get(self,request):
        '''显示'''

        # 获取登录用户对应User对象
        user = request.user

        # 获取用户的默认收货地址
        try:
            address = Address.objects.get(user=user, is_default=True) # models.Manager
        except Address.DoesNotExist:
            # 不存在默认收货地址
            address = None
        # address = Address.objects.get_default_address(user)

        # 使用模板
        return render(request, 'user_center_site.html', {'page':'address', 'address':address})

    def post(self, request):
        '''地址的添加'''
        # 接收数据
        receiver = request.POST.get('receiver')
        addr = request.POST.get('addr')
        zip_code = request.POST.get('zip_code')
        phone = request.POST.get('phone')

        # 校验数据
        if not all([receiver, addr, phone]):
            return render(request, 'user_center_site.html', {'errmsg':'数据不完整'})

        # 校验手机号
        if not re.match(r'^1[3|4|5|7|8][0-9]{9}$', phone):
            return render(request, 'user_center_site.html', {'errmsg':'手机格式不正确'})

        # 业务处理：地址添加
        # 如果用户已存在默认收货地址，添加的地址不作为默认收货地址，否则作为默认收货地址
        # 获取登录用户对应User对象
        user = request.user

        try:
            address = Address.objects.get(user=user, is_default=True)
        except Address.DoesNotExist:
            # 不存在默认收货地址
            address = None

        # address = Address.objects.get_default_address(user)

        if address:
            is_default = False
        else:
            is_default = True

        # 添加地址
        Address.objects.create(user=user,
                               receiver=receiver,
                               addr=addr,
                               zip_code=zip_code,
                               phone=phone,
                               is_default=is_default
                                )

        # 返回应答,刷新地址页面
        return redirect(reverse('users:address')) # get请求方式
