#!groovy
import hudson.security.*
import jenkins.model.*

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def users = hudsonRealm.getAllUsers()
users_s = users.collect { it.toString() }

// Create the admin user account if it doesn't already exist.
if ("${JENKINS_ADMIN_USERNAME}" in users_s) {
    println "Admin user already exists - updating password"

    def user = hudson.model.User.get('${JENKINS_ADMIN_USERNAME}');
    def password = hudson.security.HudsonPrivateSecurityRealm.Details.fromPlainPassword('${JENKINS_ADMIN_PASSWORD}')
    user.addProperty(password)
    user.save()
}
else {
    println "--> creating local admin user"

    hudsonRealm.createAccount('${JENKINS_ADMIN_USERNAME}', '${JENKINS_ADMIN_PASSWORD}')
    instance.setSecurityRealm(hudsonRealm)

    def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
    instance.setAuthorizationStrategy(strategy)
    instance.save()
}

