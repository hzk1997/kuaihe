# -*- coding: utf-8 -*-
from django.shortcuts import render
from goods.models import GoodsType, GoodsSKU, IndexGoodsBanner,IndexPromotionBanner,IndexTypeGoodsBanner

# Create your views here.
def index(request):
    '''首页'''
    return render(request, 'index.html')