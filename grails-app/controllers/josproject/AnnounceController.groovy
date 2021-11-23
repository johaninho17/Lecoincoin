package josproject

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured (['ROLE_ADMIN', 'ROLE_USER'])
class  AnnounceController {

    AnnounceService announceService
    UploadService uploadService
    SpringSecurityService springSecurityService


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        User currentUser = springSecurityService.getCurrentUser()
        def announceList
        if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN")))
            announceList = Announce.list(params)
        if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_USER")))
            announceList = Announce.list(params)
        if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_USER")))
            announceList = Announce.list(params)

        respond announceService.list(params), model:[announceCount: announceService.count()]
    }

    /*
     def announceList
  def allButUserAnnounceList = Announce.list(params)
  if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN"))) {
      announceList = Announce.list(params)
      params.max =  Math.min(max ?: 10, 100)
      respond announceList, model:[announceCount: announceList.size()]
  }
  else if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_MOD"))) {
      announceList = Announce.list(params)
      respond announceList, model:[announceCount: announceService.count()]
  }
  else if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_USER"))) {
      announceList = Announce.findAllByAuthor(currentUser)
      respond announceList = Announce.list(params)
      params.max =  announceList.size()//Math.min(max ?: 10, 100)
      respond announceList, model:[announceCount: announceList.size()]
  }

if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_USER"))) {
      allButUserAnnounceList = Announce.findAll {author == currentUser }
      respond allButUserAnnounceList, model:[announceCount: allButUserAnnounceList.size()]
  }
     */

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def indexuser(Integer max) {
        params.max = Math.min(max ?: 5, 100)

        User currentUser = springSecurityService.getCurrentUser()

        def announceList
        def allButUserAnnounceList = Announce.list(params)
        if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN"))) {
            announceList = Announce.findAllByAuthor(currentUser)
//            respond announceList = Announce.list(params)
            params.max =  announceList.size()//Math.min(max ?: 10, 100)
            respond announceList, model:[announceCount: announceList.size()]
        }
        else if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_MOD"))) {
            announceList = Announce.list(params)
            respond announceList, model:[announceCount: announceService.count()]
        }
        else if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_USER"))) {
            announceList = Announce.findAllByAuthor(currentUser)
//            respond announceList = Announce.list(params)
            params.max =  announceList.size()//Math.min(max ?: 10, 100)
            respond announceList, model:[announceCount: announceList.size()]
        }
    }

    def show(Long id) {
        respond announceService.get(id)
    }

    def create() {
        respond new Announce(params)
    }

    def save(Announce announce) {
        if (announce == null) {
            notFound()
            return
        }
        /*
        String NameVar = uploadService.upload(request)
        render(NameVar)
        announceInstance.addToIllustrations(new Illustration(filename:"grails.svg", size:100))
         */

        User currentUser = springSecurityService.getCurrentUser()

        if (currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_USER")))
            announce.author = currentUser
        announce.save(flush : true)

        announce = uploadService.upload(announce, request)



        redirect(action :"edit", id : announce.id)
    }

    /*
    UserInstance.addToAnnounce(announceInstance)
        try {
            announceService.save(announce)
        } catch (ValidationException e) {
            respond announce.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'announce.label', default: 'Announce'), announce.id])
                redirect announce
            }
            '*' { respond announce, [status: CREATED] }
        }
    }

     */


    def edit(Announce announce,Long id) {
        User currentUser = springSecurityService.getCurrentUser()

        if (currentUser != announce.getAuthor() && !currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN"))) {
            unauthorized()
            return
        }
        else
            respond announceService.get(id)
    }

    def update(Announce announce) {

        announce.price = Float.parseFloat(params.Price)

        if (announce == null) {
            notFound()
            return
        }

        uploadService.upload(announce, request)

        try {
            announceService.save(announce)
            announce.errors
        } catch (ValidationException e) {
            respond announce.errors, view:'edit'
            return
        }


//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.updated.message', args: [message(code: 'announce.label', default: 'Announce'), announce.id])
//                redirect announce
//            }
//            '*'{ respond announce, [status: OK] }
//        }

        if (params.refresh == "refresh") {
            println("a")
            redirect(action: "edit", id: announce.id)
        } else {
            println("b")
            redirect(action: "show", id: announce.id)
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        def announce = Announce.get(params.id)
        User currentUser = springSecurityService.getCurrentUser()

        if (currentUser != announce.getAuthor() && !currentUser.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN"))) {
            unauthorized()
            return
        }
        else
            announceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'announce.label', default: 'Announce'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    def deleteIllustration(){
        println("toto")
        println(params.id)
        def illustrationInstance = Illustration.get(params.id)
        def announceInstance = illustrationInstance.announce
        Announce.withTransaction {
            announceInstance.removeFromIllustrations(illustrationInstance)
            announceInstance.save()
            illustrationInstance.delete()
        }
        redirect(action :"edit", id : announceInstance.id)
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'announce.label', default: 'Announce'), params.id])
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
