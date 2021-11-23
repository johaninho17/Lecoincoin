package josproject

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured (['ROLE_ADMIN','ROLE_MOD' , 'ROLE_USER'])
class UserController {

    UserService userService
    SpringSecurityService springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        User currentUser = springSecurityService.getCurrentUser()

        def userList
        if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN")))
            userList = User.list(params)

        else if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_MOD")))
            userList = User.list(params)

        else if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_USER")))
            userList = User.findAllByUsername(currentUser)

        respond userList, model:[userCount: userList.size()]
    }

    def show(Long id) {
        def user =  User.get(params.id)
        respond user
    }


    def create() {
        respond new User(params)
    }

    def save(User user) {

        User currentUser = springSecurityService.getCurrentUser()

        if (user == null) {
            notFound()
            return
        }

        try {
            userService.save(user)
            if(currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN"))){
                def role = Role.get(params.UserRole)
                UserRole.removeAll(user)
                UserRole.create(user, role, true)
            }else{
                def userRole = Role.findByAuthority('ROLE_USER')
                UserRole.create(user, userRole, true)
            }



        } catch (ValidationException e) {
            respond user.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*' { respond user, [status: CREATED] }
        }
    }

    def edit(Long id) {
        User currentUser = springSecurityService.getCurrentUser()
        def user = User.get(params.id)
        if (currentUser != user && !currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN"))) {
            unauthorized()
            return
        }
        else
            respond userService.get(id)
    }

    def update() {
        def user =User.get(params.id)
        user.username = params.username

        if(params.password !=""){
            user.password = params.password
        }
        if (user == null) {
            notFound()
            return
        }

        try {
            userService.save(user)
            def role = Role.get(params.UserRole)
            UserRole.removeAll(user)
            UserRole.create(user, role, true)

        } catch (ValidationException e) {
            respond user.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        User currentUser = springSecurityService.getCurrentUser()
        def user = User.get(params.id)

        if(user.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN")) && user == currentUser){
            unauthorized()
            return
        }
        if (currentUser != user && !currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN"))) {
            unauthorized()
            return
        }
        else{
            UserRole.removeAll(user)
            userService.delete(id)
        }


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    protected void unauthorized() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.unauthorized.message', args: [message(code: 'announce.label', default: 'Announce'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: UNAUTHORIZED }
        }
    }
}
