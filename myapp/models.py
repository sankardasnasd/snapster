from django.db import models

# Create your models here.
class Login(models.Model):
    username=models.CharField(max_length=100)
    password=models.CharField(max_length=100)
    type=models.CharField(max_length=100)

class User(models.Model):
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)
    name=models.CharField(max_length=100)
    place=models.CharField(max_length=100)
    posts=models.CharField(max_length=100)
    email=models.CharField(max_length=100)
    phone=models.CharField(max_length=100)
    photo=models.CharField(max_length=400)
    # latitude=models.CharField(max_length=100)
    # longitude=models.CharField(max_length=100)

class Complaint(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    date=models.CharField(max_length=100)
    complaint=models.CharField(max_length=400)
    reply=models.CharField(max_length=300)

class Feedback(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    date=models.CharField(max_length=100)
    rating=models.CharField(max_length=400)
    feedback=models.CharField(max_length=300)

class Post(models.Model):
    USER = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.CharField(max_length=100)
    type = models.CharField(max_length=100)
    file = models.CharField(max_length=100)
    title = models.CharField(max_length=300)


class Comment(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    POST=models.ForeignKey(Post,on_delete=models.CASCADE)
    date=models.CharField(max_length=100)
    comment=models.CharField(max_length=100)
    status=models.CharField(max_length=300)
    # total=models.CharField(max_length=300)


class Like(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    POST=models.ForeignKey(Post,on_delete=models.CASCADE)
    date=models.CharField(max_length=100)
    status=models.CharField(max_length=300)
    total=models.CharField(max_length=300)
    type=models.CharField(max_length=300)


class Disike(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    POST=models.ForeignKey(Post,on_delete=models.CASCADE)
    date=models.CharField(max_length=100)
    status=models.CharField(max_length=300)
    total=models.CharField(max_length=300)


class Report(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    COMMENT=models.ForeignKey(Comment,on_delete=models.CASCADE)
    date=models.CharField(max_length=100)
    status=models.CharField(max_length=300)


class Follow_request(models.Model):
    FROM=models.ForeignKey(User,on_delete=models.CASCADE,related_name='from_id')
    TO=models.ForeignKey(User,on_delete=models.CASCADE,related_name='to_id')
    date=models.CharField(max_length=100)
    status=models.CharField(max_length=300)



class Chat(models.Model):
    FROMID= models.ForeignKey(Login,on_delete=models.CASCADE,related_name="Fromid")
    TOID= models.ForeignKey(Login,on_delete=models.CASCADE,related_name="Toid")
    message=models.CharField(max_length=100)
    date=models.DateField()