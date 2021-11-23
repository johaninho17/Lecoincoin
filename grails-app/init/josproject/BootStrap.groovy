package josproject

class BootStrap {

    def init = { servletContext ->

        def adminRole = new Role (authority : 'ROLE_ADMIN').save(flush:true)
        def modRole = new Role (authority : 'ROLE_MOD').save(flush:true)
        def userRole = new Role (authority : 'ROLE_USER').save(flush:true)

        def adminUserInstance = new User( username : 'admin' , password : 'admin').save(flush:true)

        UserRole.create(adminUserInstance, adminRole)

        ['Alice','Bob','Charly','Denis','Etienne'].each{
            String username ->
                def userInstance = new User(username:username, password:"password").save(flush:true)
                UserRole.create(userInstance, userRole)
                (1..5).each{
                    Integer announceIdx ->
                        def announceInstance = new Announce(title:"Title Announce $announceIdx $username",
                                description:"Description de l'announce",
                                price:100*announceIdx)
                        (1..5).each{
                            announceInstance.addToIllustrations(new Illustration(filename:"grails.svg", size:100))
                        }
                        userInstance.addToAnnounce(announceInstance)
                }
                userInstance.save(flush:true)
        }
    }
    def destroy = {
    }
}
