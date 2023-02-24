from django.urls import path, include

from . import views

urlpatterns = [
    path('', include('dj_rest_auth.urls')),
    path('auth-user/', views.UserDetail.as_view(), name='user_detail'),
]
