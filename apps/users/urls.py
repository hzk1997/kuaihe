# -*- coding: utf-8 -*-
from django.conf.urls import url
from django.contrib.auth.decorators import login_required
from users.views import RegisterView, LogoutView, LoginView, UserInfoView, UserOrderView, AddressView

urlpatterns = [
    url(r'^register$', RegisterView.as_view(), name='register'), #注册

    url(r'^login$', LoginView.as_view(), name='login'), # 登录
    url(r'^logout$', LogoutView.as_view(), name='logout'),  # 注销登录

    # url(r'^$', login_required(UserInfoView.as_view()), name='user'),   #
    # url(r'^order$', login_required(UserOrderView.as_view()), name='order'),  #
    # url(r'^address$',login_required(AddressView.as_view()), name='address'), #

    url(r'^$', UserInfoView.as_view(), name='user'), # 用户中心-信息页
    url(r'^order$', UserOrderView.as_view(), name='order'), # 用户中心-订单页
    url(r'^address$', AddressView.as_view(), name='address'), # 用户中心-地址页
]
