
from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static

from myapp import views
from snapture import settings

urlpatterns = [
    path('',views.login),
    path('logout',views.logout),
    path('login_post',views.login_post),
    path('admin_home',views.admin_home),
    path('admin_view_user',views.admin_view_user),
    path('view_reports',views.view_reports),
    path('view_reported_users2',views.view_reported_users2),

    path('block_user/<int:user_id>/', views.block_user2),

    path('view_feedback',views.view_feedback),
    path('view_complaint',views.view_complaint),
    path('sendreply_post',views.sendreply_post),
    path('report_comments_view',views.report_comments_view),
    path('send_reply/<id>',views.send_reply),
    path('admin_delete_comment/<id>',views.admin_delete_comment),
    path('block_user/<int:id>/', views.block_user, name='block_user'),

    path('user_reg', views.user_reg),
    path('user_home', views.user_home),
    path('user_send_feedback', views.user_send_feedback),
    path('user_home2', views.user_home2),
    path('user_view_complaint', views.user_view_complaint),
    path('send_complaint', views.send_complaint),
    path('add_post', views.add_post),
    path('send_comment_post', views.send_comment_post),
    path('like_post/<id>', views.like_post),
    path('like/<id>', views.like),
    path('send_comment/<id>', views.send_comment),
    path('user_view_comment/<id>', views.user_view_comment),
    path('report_user/<id>', views.report_user),

    path('user_send_like/<id>', views.user_send_like),
    path('own_user_send_like/<id>', views.own_user_send_like),
    path('user_send_dislike/<id>', views.user_send_dislike),
    path('user_owb_send_dislike/<id>', views.user_owb_send_dislike),

    path('user_detete_comment/<id>', views.user_detete_comment),
    path('user_view_own_post', views.user_view_own_post),
    path('user_send_own_like', views.user_send_own_like),
    path('view_user_profile', views.view_user_profile),
    path('user_view_all_user', views.user_view_all_user),
    path('user_view_all_user_request', views.user_view_all_user_request),
    path('view_frieds', views.view_frieds),
    path('user_send_request/<id>', views.user_send_request),
    path('accept_request/<id>', views.accept_request),
    path('reject_request/<id>', views.reject_request),
    path('user_chat_to_user1/<id>', views.user_chat_to_user1),
    path('chat_view', views.chat_view),
    path('chat_send/<msg>', views.chat_send),

]


