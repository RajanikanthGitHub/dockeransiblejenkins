FROM tomcat:8
# Take the war file and copy to webapps of Tomcat
COPY target/*.war /usr/local/tomcat/webapps/dockeransiblejenkins.war