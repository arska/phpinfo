# PHP Sample Application

This is a very simple PHP application showing information about the PHP environment. I use it to show the speed and simpleness of an http://appuio.ch source to image process

* Web-GUI: "Add to project" -> search for "PHP" -> Choose "PHP" -> Next -> Version: 7.0, Name: phpinfo, Git Repository: https://github.com/arska/phpinfo.git -> Create -> Close

* CLI using source-to-image (s2i):
```
oc new-app php:7.0~https://github.com/arska/phpinfo.git
oc expose service phpinfo
```
* CLI using Dockerfile:
```
oc new-app --strategy=docker https://github.com/arska/phpinfo.git
oc expose service phpinfo
```
* CLI using OpenShift Template:
```
oc new-app -f https://raw.githubusercontent.com/arska/phpinfo/master/template.yaml -p NAME=phpinfo
```

You can clean up the application with:
```
oc delete all -l app=phpinfo
```

You can also build/run the application locally using docker:
```
docker build -t phpinfo .
docker run -p 8080:8080 phpinfo
```
The application is then accessible at http://127.0.0.1:8080/

## Demo walkthrough

### prepare

* log in to https://console.appuio.ch/
* go to github.com and add a webhook to preempt "sudo mode" password question

### demo

```
Add to project -> show all available builders
choose php builder, e.g. 7.0
name example, git https://github.com/arska/phpinfo, create without options
copy webhook url, click on github link, add webhook url to github, choose JSON as format !
go back to console tab, go to overview, check build log if not ready, back to overview
show generated URL on top right, click, show running app, back to console
easy to scale up, scale to 2 and 3 pods, mouse hover on the "starting" pods
easy to scale down, go back to 1 pod
add encryption: menu application -> routes -> click on name -> actions -> edit -> show options for ... -> TLS: Edge, Insecure: Redirect
overview: URL changed to https, click and show green lock in browser URL
scale back up to 3
go to github, click index.php, edit, edit echo message at top, commit
console: show build, show rolling upgrade, click on link, show new message
```

### cleanup
```
oc delete all -l app=example
```

