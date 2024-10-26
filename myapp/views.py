import datetime
from django.core.files.storage import FileSystemStorage
from django.db.models import Q
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

# Create your views here.
from myapp.models import *


def logout(request):
    request.session['lid']=''
    return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')


def login(request):
    return render(request,'login.html')

def login_post(request):
    username = request.POST['username']
    password = request.POST['psw']

    a = Login.objects.filter(username=username, password=password)
    if a.exists():
        b = Login.objects.get(username=username, password=password)
        request.session['lid'] = b.id
        if b.type == 'admin':
            return HttpResponse('''<script>alert("Login successfully ");window.location='/admin_home'</script>''')
        elif b.type == 'user':
            return HttpResponse('''<script>alert("Login successfully ");window.location='/user_home'</script>''')
        else:
            return HttpResponse('''<script>alert("Invalid ");window.location='/'</script>''')
    else:
        return HttpResponse('''<script>alert("Invalid ");window.location='/'</script>''')


def admin_home(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    a=Report.objects.all()
    acount=a.count()
    request.session['acount']=acount

    b = User.objects.all()
    bcount = b.count()
    request.session['bcount'] = bcount

    com = Complaint.objects.all()
    comcount = com.count()
    request.session['comcount'] = comcount

    po = Post.objects.all()
    pocount = po.count()
    request.session['pocount'] = pocount

    return render(request,'admin/home.html',{'pocount':pocount,'acount':acount,'bcount':bcount,'comcount':comcount})


def admin_view_user(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    a=User.objects.all().order_by('-id')
    return render(request,'admin/view_user.html',{'data':a})


# def view_reports(request):
#     reports = Report.objects.filter(status='Reported').order_by('-id')  # Retrieve all reports
#     return render(request, 'admin/view_reports.html', {'reports': reports})

from django.shortcuts import render, redirect
from .models import Report, User, Login

def view_reports(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    reports = Report.objects.all()

    user_report_count = {}

    # Count reports for each user
    for report in reports:
        user_id = report.USER.id
        if user_id in user_report_count:
            user_report_count[user_id] += 1
        else:
            user_report_count[user_id] = 1

    # Block users with more than 5 reports
    for user_id, count in user_report_count.items():
        if count > 5:
            user = User.objects.get(id=user_id)
            login = user.LOGIN
            login.type = 'block'
            login.save()

    # Pass reports to the template
    return render(request, 'admin/view_reports.html', {'reports': reports})


from django.db.models import Count

# def view_reported_users2(request):
#     # Get users with more than 5 reports on their comments
#     reported_users = Report.objects.values('USER__name', 'USER__id') \
#         .annotate(report_count=Count('USER')) \
#         .filter(report_count__gt=5)
#
#     return render(request, 'admin/view_reported_users2.html', {'reported_users': reported_users})


from django.db.models import Count

def view_reported_users2(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    # Get users with more than 5 reports on their comments (related to the Comment table)
    reported_users = Report.objects.values('COMMENT__USER__name', 'COMMENT__USER__id') \
        .annotate(report_count=Count('COMMENT__USER')) \
        .filter(report_count__gt=5)

    return render(request, 'admin/view_reported_users2.html', {'reported_users': reported_users})


from django.shortcuts import get_object_or_404
from django.http import HttpResponse


def block_user2(request, user_id):
    # Get the user object based on the user ID
    user = get_object_or_404(User, id=user_id)

    # Get the associated login object to change the type to 'blocked'
    login = user.LOGIN
    login.type = 'blocked'  # Change the user type to 'blocked'
    login.save()

    return HttpResponse(
        '''<script>alert("User Blocked Successfully");window.location='/view_reported_users2'</script>''')


from django.shortcuts import redirect
from .models import User

def block_user(request, id):

        # Get the user by ID
    user = User.objects.get(id=id)
    # Set the login type to 'block'
    user.LOGIN.type = 'block'
    user.LOGIN.save()

    # Redirect with a success message
    return HttpResponse('''<script>alert("User Blocked Successfully");window.location='/admin/view_reports'</script>''')



def admin_delete_comment(request,id):
    a=Report.objects.get(id=id)
    a.COMMENT.delete()
    return redirect('/admin_home')

from django.shortcuts import render, redirect, get_object_or_404
from .models import User, Login

def block_user(request,id):

    return redirect('/view_reports')  # Redirect to the user list or another relevant page


def view_feedback(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    reports = Feedback.objects.all().order_by('-id')  # Retrieve all reports
    return render(request, 'admin/view_feedback.html', {'data': reports})
def view_complaint(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    reports = Complaint.objects.all().order_by('-id')  # Retrieve all reports
    return render(request, 'admin/view_complaints.html', {'users': reports})

def send_reply(request,id):
    a=Complaint.objects.get(id=id)
    return render(request, 'admin/sendreply.html', {'data': a})


def sendreply_post(request):
    id=request.POST['id']
    reply=request.POST['reply']

    a=Complaint.objects.get(id=id)
    a.reply=reply
    a.save()
    return HttpResponse('''<script>alert("Replied ");window.location='/view_complaint'</script>''')


def report_comments_view(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    # Fetch all reports
    reports = Report.objects.select_related('COMMENT').all()

    context = {
        'reports': reports,
    }
    return render(request, 'admin/view comment.html', context)



def user_reg(request):
    if 'submit' in request.POST:
        name=request.POST['name']
        email=request.POST['email']
        phone=request.POST['phone']
        place=request.POST['place']
        password=request.POST['password']
        post=request.POST['post']
        image=request.FILES['image']
        fs = FileSystemStorage()
        date = datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S") + '.jpg'
        fs.save(date, image)
        path = fs.url(date)

        a=Login.objects.filter(username=email)
        if a.exists():
            return HttpResponse('''<script>alert(" username Already taken ");window.location='/user_reg'</script>''')
        aa=Login()
        aa.username=email
        aa.password=password
        aa.type='user'
        aa.save()

        u=User()
        u.LOGIN=aa
        u.name=name
        u.phone=phone
        u.email=email
        u.posts=post
        u.place=place
        u.photo=path
        u.save()
        return HttpResponse('''<script>alert(" Success ");window.location='/'</script>''')

    return render(request,'register.html')


# def user_home(request):
#     a=Post.objects.all()
#     for i in a:
#         lik=Like.objects.filter(POST__id=i.id)
#         i.lc=len(lik)
#
#         i.ml=False
#         mylike=Like.objects.filter(POST__id=i.id,USER__LOGIN__id=request.session['lid'])
#         if len(mylike)>0:
#             i.ml=True
#
#         c=Comment.objects.filter(POST__id=i.id)
#         i.co=len(c)
#         i.cl=False
#         mycomment=Comment.objects.filter(POST__id=i.id,USER__LOGIN_id=request.session['lid'])
#         if len(mycomment)>0:
#             i.cl=True
#
#
#
#
#         return render(request,'user/user_home.html',{'data':a})


from django.shortcuts import redirect
from .models import Post, Like, Comment

def user_home(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    a = Post.objects.all()
    for i in a:
        lik = Like.objects.filter(POST__id=i.id,status='liked')
        i.lc = len(lik)


        i.ml = False
        mylike = Like.objects.filter(POST__id=i.id, USER__LOGIN__id=request.session['lid'])
        if len(mylike) > 0:
            i.ml = True

        d=Disike.objects.filter(POST__id=i.id,status='disliked')
        i.dl=len(d)



        c = Comment.objects.filter(POST__id=i.id)
        i.co = len(c)
        i.cl = False
        mycomment = Comment.objects.filter(POST__id=i.id, USER__LOGIN_id=request.session['lid'])
        if len(mycomment) > 0:
            i.cl = True



    return render(request, 'user/user_home.html', {'data': a})

# def like_post(request, id):
#     if request.method == 'POST':
#         post = Post.objects.get(id=id)
#         user = request.user  # Assuming you have user session
#
#         # Check if the user has already liked the post
#         like, created = Like.objects.get_or_create(POST=post, USER=user)
#
#         if not created:
#             # If already liked, remove the like
#             like.delete()
#         # Redirect back to the user home page
#         return redirect('/user_home')  # Replace 'user_home' with your URL name


from django.shortcuts import get_object_or_404, redirect
from django.utils import timezone

# def like_post(request, id):
#     if request.method == 'POST':
#         post = get_object_or_404(Post, id=id)
#         user = User.objects.get(LOGIN_id=request.session['lid']) # Get the current logged-in user
#
#         like, created = Like.objects.get_or_create(POST=post, USER=user)
#
#         if not created:
#             like.delete()
#         else:
#             like.date = timezone.now()  # Example of setting the date
#             like.status = 'liked'  # You can customize this as per your logic
#             like.save()  # Save the new like instance
#
#         return redirect('/user_home')  # Replace with your actual URL pattern name
#
#     return redirect('/user_home')  # Handle other HTTP methods


from django.shortcuts import get_object_or_404, redirect
from django.utils import timezone

def like_post(request, id):
    if request.method == 'POST':
        post = get_object_or_404(Post, id=id)  # Get the post by id
        user = User.objects.get(LOGIN_id=request.session['lid'])  # Get the current logged-in user

        like, created = Like.objects.get_or_create(POST=post, USER=user)

        if not created:
            like.delete()
        else:
            like.date = timezone.now().strftime("%Y-%m-%d %H:%M:%S")  # Set the current date and time
            like.status = 'liked'  # Set the status to liked
            like.save()  # Save the new like instance

        return redirect('/user_home')  # Replace with your actual URL pattern name

    return redirect('/user_home')  # Handle other HTTP methods


def like(request,id):
    a=Like()
    a.POST=Post.objects.get(id=id)
    a.type='Liked'
    a.date=datetime.datetime.now().today().date()
    a.USER=User.objects.get(LOGIN_id=request.session['lid'])
    a.save()
    return redirect('/user_home')



def user_view_own_post(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    a=Post.objects.filter(USER__LOGIN_id=request.session['lid'])
    for i in a:
        like=Like.objects.filter(POST__id=i.id,POST__USER__LOGIN_id=request.session['lid'],status='liked')
        i.lc=len(like)

        com=Comment.objects.filter(POST__id=i.id,POST__USER__LOGIN_id=request.session['lid'])
        i.cc=len(com)

        d = Disike.objects.filter(POST__id=i.id,POST__USER__LOGIN_id=request.session['lid'], status='disliked')
        i.dl = len(d)

    return render(request,'user/user_view_own_post.html',{'data':a})

def user_home2(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    return render(request,'user/user_home2.html')


def user_send_feedback(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    if 'submit' in request.POST:
        rating = request.POST['rating']
        review = request.POST['review']  # Ensure this matches the form field name

        a = Feedback()
        a.USER = User.objects.get(LOGIN_id=request.session['lid'])
        a.date = datetime.datetime.now().today().date()
        a.rating = rating
        a.feedback = review
        a.save()
        return HttpResponse('''<script>alert("Feedback Sent ");window.location='/user_home'</script>''')

    return render(request, 'user/send feedback.html')

def user_view_complaint(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    if request.session['lid'] == '':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    a=Complaint.objects.filter(USER__LOGIN_id=request.session['lid']).order_by('-id')
    return render(request,'user/view compla.html',{'data':a})

def send_complaint(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    if 'submit' in request.POST:
        compl=request.POST['com']
        a=Complaint()
        a.USER=User.objects.get(LOGIN_id=request.session['lid'])
        a.date = datetime.datetime.now().today().date()
        a.reply='pending'
        a.complaint=compl
        a.save()
        return HttpResponse('''<script>alert(" Sent ");window.location='/user_home'</script>''')

    return render(request,'user/send complaints.html')





from django.shortcuts import render, redirect
from django.core.files.storage import FileSystemStorage
from django.contrib import messages
from .models import Complaint  # Assuming you have a model for complaints


def add_post(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    if request.method == 'POST':
        type_of_complaint = request.POST.get('type')
        title = request.POST.get('title')
        file = request.FILES.get('image') if type_of_complaint == 'image' else request.FILES.get('video')

        if not title or not file:
            messages.error(request, "All fields are required.")
            return redirect('/add_post')

        fs = FileSystemStorage()
        date2 = datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S")

        filename = fs.save(date2, file)
        path = fs.url(date2)

        complaint = Post.objects.create(
            type=type_of_complaint,
            file=path,
            title=title,
            date=datetime.datetime.now().today(),
            USER=User.objects.get(LOGIN_id=request.session['lid']),
        )

        messages.success(request, " Added successfully.")
        return HttpResponse('''<script>alert(" Added ");window.location='/user_home'</script>''')

    return render(request, 'user/add post.html')


def send_comment(request,id):
    a=Post.objects.get(id=id)
    return render(request,'user/send coments.html',{'data':a})


def send_comment_post(request):
    id=request.POST['id']
    com=request.POST['com']
    a=Comment()
    a.POST=Post.objects.get(id=id)
    a.USER=User.objects.get(LOGIN_id=request.session['lid'])
    a.comment=com
    a.date=datetime.datetime.now().today().date()
    a.save()
    return HttpResponse('''<script>alert(" Commented ");window.location='/user_home'</script>''')


def user_view_comment(request,id):
    a=Comment.objects.filter(POST_id=id).order_by('-id')
    post=Post.objects.get(id=id)
    print(post)
    return render(request,'user/view comment.html',{'data':a,'post':post})

def user_detete_comment(request,id):
    a=Comment.objects.get(id=id)
    a.delete()
    return HttpResponse('''<script>alert(" Deleted ");window.location='/user_home'</script>''')

def report_user(request,id):
    a=Report()
    a.COMMENT=Comment.objects.get(id=id)
    a.status='Reported'
    a.date=datetime.datetime.now().today().date()
    a.USER=User.objects.get(LOGIN_id=request.session['lid'])
    a.save()
    return HttpResponse('''<script>alert(" Reported ");window.location='/user_home'</script>''')



# def user_send_like(request,id):
#     a=Like()
#     a.POST=Post.objects.get(id=id)
#     a.date=datetime.datetime.now().today()
#     a.status='liked'
#     a.USER=User.objects.get(LOGIN_id=request.session['lid'])
#     a.save()
#     return redirect('/user_home')


def user_send_like(request, id):
    post = get_object_or_404(Post, id=id)

    user = get_object_or_404(User, LOGIN_id=request.session['lid'])

    dislike, created = Like.objects.get_or_create(POST=post, USER=user)

    if not created:
        dislike.delete()  # Remove the existing dislike
    else:
        dislike.date = timezone.now().strftime("%Y-%m-%d %H:%M:%S")  # Set the current date and time
        dislike.status = 'liked'  # Set the status to disliked
        dislike.save()  # Save the dislike instance

    return redirect('/user_home')  # Replace with your actual URL pattern name

def own_user_send_like(request, id):
    post = get_object_or_404(Post, id=id)

    user = get_object_or_404(User, LOGIN_id=request.session['lid'])

    dislike, created = Like.objects.get_or_create(POST=post, USER=user)

    if not created:
        dislike.delete()  # Remove the existing dislike
    else:
        dislike.date = timezone.now().strftime("%Y-%m-%d %H:%M:%S")  # Set the current date and time
        dislike.status = 'liked'  # Set the status to disliked
        dislike.save()  # Save the dislike instance

    return redirect('/user_view_own_post')  # Replace with your actual URL pattern name



# def user_send_dislike(request,id):
#     a=Disike()
#     a.POST=Post.objects.get(id=id)
#     a.date=datetime.datetime.now().today()
#     a.status='disliked'
#     a.USER=User.objects.get(LOGIN_id=request.session['lid'])
#     a.save()
#     return redirect('/user_home')




from django.shortcuts import get_object_or_404, redirect
from django.utils import timezone


def user_send_dislike(request, id):
    post = get_object_or_404(Post, id=id)

    user = get_object_or_404(User, LOGIN_id=request.session['lid'])

    dislike, created = Disike.objects.get_or_create(POST=post, USER=user)

    if not created:
        dislike.delete()  # Remove the existing dislike
    else:
        dislike.date = timezone.now().strftime("%Y-%m-%d %H:%M:%S")  # Set the current date and time
        dislike.status = 'disliked'  # Set the status to disliked
        dislike.save()  # Save the dislike instance

    return redirect('/user_home')  # Replace with your actual URL pattern name

def user_owb_send_dislike(request, id):
    post = get_object_or_404(Post, id=id)

    user = get_object_or_404(User, LOGIN_id=request.session['lid'])

    dislike, created = Disike.objects.get_or_create(POST=post, USER=user)

    if not created:
        dislike.delete()  # Remove the existing dislike
    else:
        dislike.date = timezone.now().strftime("%Y-%m-%d %H:%M:%S")  # Set the current date and time
        dislike.status = 'disliked'  # Set the status to disliked
        dislike.save()  # Save the dislike instance

    return redirect('/user_view_own_post')  # Replace with your actual URL pattern name


def user_send_own_like(request,id):
    a=Like()
    a.POST=Post.objects.get(id=id)
    a.status='liked'
    a.USER=User.objects.get(LOGIN_id=request.session['lid'])
    a.save()
    return redirect('/user_home')

def view_user_profile(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    user = User.objects.get(LOGIN_id=request.session['lid'])
    return render(request, 'user/profile.html', {'user': user})


# def user_view_all_user(request):
#     a=User.objects.all().exclude(LOGIN_id=request.session['lid'])
#     return render(request,'user/view users.html',{'data':a})


def user_view_all_user(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    # Get the current user's login ID from the session
    current_user_id = request.session.get('lid')

    # Retrieve all users excluding the current user
    users = User.objects.exclude(LOGIN_id=current_user_id)

    # Render the template with the user data
    return render(request, 'user/view users.html', {'data': users})


def user_view_all_user_request(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    a=Follow_request.objects.filter(TO__LOGIN_id=request.session['lid'],status='pending')
    print(a)
    return render(request,'user/view friends users.html',{'data':a})

# def view_frieds(request):
#     a=Follow_request.objects.filter(Q(status='friend',TO__LOGIN_id=request.session['lid'])|(status='friend',TO__LOGIN_id=request.session['lid']))
#     print(a)
#     return render(request,'user/view friends .html',{'data':a})

#
# from django.db.models import Q
#
# def view_frieds(request):
#     a = Follow_request.objects.filter(
#         Q(status='friend', TO__LOGIN_id=request.session['lid']) |
#         Q(status='friend', FROM__LOGIN_id=request.session['lid'])
#     )
#     print(a)
#     return render(request, 'user/view friends .html', {'data': a})



from django.db.models import Q


def view_frieds(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("Logout successfully ");window.location='/'</script>''')

    user_id = request.session['lid']

    a = Follow_request.objects.filter(
        (Q(status='friend') &
         (Q(TO__LOGIN_id=user_id) | Q(FROM__LOGIN_id=user_id)))
    ).exclude(TO__LOGIN_id=user_id)  # Exclude self as both TO and FROM

    print(a)
    return render(request, 'user/view friends .html', {'data': a})


# def user_send_request(request,id):
#     aa=Follow_request.objects.filter(TO__LOGIN_id=request.session['lid'],FROM__LOGIN_id=request.session['lid'])
#     if aa.exists():
#         return HttpResponse('''<script>alert(" Already Requested ");window.location='/user_view_all_user_request'</script>''')
#
#     a=Follow_request()
#     a.status='pending'
#     a.FROM=User.objects.get(LOGIN_id=request.session['lid'])
#     a.TO=User.objects.get(id=id)
#     a.date=datetime.datetime.now().today().date()
#     a.save()
#     return HttpResponse('''<script>alert(" Requested ");window.location='/user_view_all_user_request'</script>''')


def user_send_request(request, id):
    # Check if a follow request already exists from the current user (FROM) to the target user (TO)
    aa = Follow_request.objects.filter(FROM__LOGIN_id=request.session['lid'], TO__id=id)

    # If a request already exists, display an alert and redirect
    if aa.exists():
        return HttpResponse(
            '''<script>alert("Already Requested");window.location='/user_view_all_user_request'</script>''')

    # If no request exists, create a new follow request
    a = Follow_request()
    a.status = 'pending'
    a.FROM = User.objects.get(LOGIN_id=request.session['lid'])  # current user
    a.TO = User.objects.get(id=id)  # target user
    a.date = datetime.datetime.now().today().date()
    a.save()

    return HttpResponse('''<script>alert("Requested");window.location='/user_view_all_user_request'</script>''')


def accept_request(request,id):
    a=Follow_request.objects.filter(id=id).update(status='friend')
    return HttpResponse('''<script>alert(" Accepted ");window.location='/user_view_all_user_request'</script>''')
def reject_request(request,id):
    a=Follow_request.objects.filter(id=id).update(status='Rejected')
    return HttpResponse('''<script>alert(" Rejected ");window.location='/user_view_all_user_request'</script>''')




def user_chat_to_user1(request, id):
    request.session["userid"] = id
    cid = str(request.session["userid"])
    request.session["new"] = cid
    qry = Follow_request.objects.get(TO__LOGIN=cid)
    print(qry.TO.LOGIN_id,'login----------')

    return render(request, "user/Chat.html", {'photo': qry.TO.photo, 'name': qry.TO.name, 'toid': cid})

def chat_view(request):
    fromid = request.session["lid"]
    toid = request.session["userid"]
    qry = Follow_request.objects.get(TO__LOGIN_id=request.session["userid"])
    from django.db.models import Q

    res = Chat.objects.filter(Q(FROMID_id=fromid, TOID_id=toid) | Q(FROMID_id=toid, TOID_id=fromid)).order_by('id')
    l = []
    print(qry.TO.name,'userssssssssss')

    for i in res:
        l.append({"id": i.id, "message": i.message, "to": i.TOID_id, "date": i.date, "from": i.FROMID_id})

    return JsonResponse({'photo': qry.TO.photo, "data": l, 'name': qry.TO.name, 'toid': request.session["userid"]})

def chat_send(request, msg):
    lid = request.session["lid"]
    toid = request.session["userid"]
    message = msg

    import datetime
    d = datetime.datetime.now().date()
    chatobt = Chat()
    chatobt.message = message
    chatobt.TOID_id = toid
    chatobt.FROMID_id = lid
    chatobt.date = d
    chatobt.save()

    return JsonResponse({"status": "ok"})

# def user_chat_to_user1(request, id):
#     request.session["userid"] = id
#     cid = str(request.session["userid"])
#     request.session["new"] = cid
#     qry = Follow_request.objects.get(TO__LOGIN=cid)
#     print(qry.TO.LOGIN_id,'login----------')
#
#     return render(request, "user/Chat.html", {'photo': qry.TO.photo, 'name': qry.TO.name, 'toid': cid})
