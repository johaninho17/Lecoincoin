package josproject

import grails.converters.JSON
import grails.converters.XML
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityService
import org.apache.commons.lang.RandomStringUtils
import org.springframework.web.multipart.MultipartHttpServletRequest

@Secured('ROLE_ADMIN')
class ApiController {

    SpringSecurityService springSecurityService
    def passwordEncoder
    UploadService uploadService
    FileUtil fileUtil

    //api/user/**
    //get/put/patch/delete
    def user()
    {
        User currentUser = springSecurityService.getCurrentUser()
        switch(request.getMethod())
        {
            case "GET":
                if(!params.id)
                    return response.status = 400
                def userInstance = User.get(params.id)
                if(!userInstance)
                    return response.status = 404
                renderUser(userInstance, request.getHeader('Accept'))
                break;
            case "PUT":
                if(!params.id)
                    respond([message:"Invalid user id"], status: 400)
                def userInstance = User.get(params.id)
                if(!request.JSON.username && !request.JSON.password){
                    respond([message:"username or password cannot be empty"], status: 400)
                }
                userInstance.username = request.JSON.username
                if(!passwordEncoder.isPasswordValid(userInstance.password, request.JSON.password, null)){
                    userInstance.password = request.JSON.password
                }
                userInstance.save(flush: true)
                return response.status = 200
                break;
            case "PATCH":
                if(!params.id)
                    return response.status = 400
                def userInstance = User.get(params.id)
                if(request.JSON.username){
                    userInstance.username = request.JSON.username
                }
                if(request.JSON.password){
                    if(!passwordEncoder.isPasswordValid(userInstance.password, request.JSON.password, null)){
                        userInstance.password = request.JSON.password
                    }
                }
                userInstance.save(flush: true)
                return response.status = 200
                break;
            case "DELETE":
                if(!params.id)
                    respond([message:"Invalid user id"], status: 400)
                def userInstance = User.get(params.id)
                if(!userInstance)
                    respond([message:"User doesnt exist"], status: 404)

                if(userInstance.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN")) && userInstance == currentUser){
                    respond([message:"Admin cannot delete themselves (must go through another admin)"], status: 400)
                    return
                }

                UserRole.removeAll(userInstance)
                userInstance.delete(flush:true)
                respond([message:"User successfully deleted"], status: 200)

                if(!userInstance.delete())
                    respond([message:"User cannot be deleted"], status: 404)
                break;
            default:
                break;
        }
    }

    def users()
    {
        switch(request.getMethod())
        {
            case "GET":
                def usersList = User.getAll()
                if(!usersList)
                    return response.status = 404
                //return response.status = 200
                renderUsers(usersList, request.getHeader('Accept'))
                break;
            case "POST":
                def newUserInstance
                def role

                if(User.findByUsername(request.JSON.username))
                    respond([message:"username has already been used"], status: 400)

                if(!request.JSON.username || !request.JSON.password || !request.JSON.role)
                respond([message:"missing user creation properties cant be created"], status: 400)

                User.withTransaction {
                    newUserInstance = new User(username: request.JSON.username , password: request.JSON.password).save()
                    role = Role.findByAuthority(request.JSON.role)
                    UserRole.create(newUserInstance, role)
                }

                if(!newUserInstance || !role)
                    return response.status = 404
                return response.status = 201
                break;
        }
    }

    def announce()
    {
        switch(request.getMethod())
        {
            case "GET":
                if(!params.id)
                    return response.status = 400
                def announceInstance = Announce.get(params.id)
                if(!announceInstance)
                    return response.status = 404
                renderAnnounce(announceInstance, request.getHeader('Accept'))
                break;
            case "PUT":
                if(!params.id)
                    respond([message:"Invalid announce id"], status: 400)
                def announceInstance = Announce.get(params.id)
                if(!request.JSON.title && !request.JSON.description && !Float.parseFloat(request.JSON.price)){
                    respond([message:"Announce entities are null"], status: 400)
                }
                announceInstance.title = request.JSON.title
                announceInstance.description = request.JSON.description
                announceInstance.price = Float.parseFloat(request.JSON.price)
                request.JSON.illustrations.each{
                    Map obj ->
                        def illus = Illustration.get(obj.id)
                        illus.announce = announceInstance
                }
                announceInstance.save(flush: true)
                return response.status = 200
                break;
            case "PATCH":
                if(!params.id)
                    return response.status = 400
                def announceInstance = Announce.get(params.id)

                if(request.JSON.title){
                    announceInstance.title = request.JSON.title
                }
                if(request.JSON.description){
                    announceInstance.description = request.JSON.description
                }
                if(request.JSON.price){
                    announceInstance.price = Float.parseFloat(request.JSON.price)
                }
                return response.status = 200
                break;
            case "POST":
                if(!params.id)
                    return response.status = 400
                def announceInstance = Announce.get(params.id)

                if(request.getFile("payload"))
                    addillus()
                break;
                //announceInstance.save(flush: true)
            case "DELETE":
                if(!params.id)
                    respond([message:"Invalid announce id"], status: 400)
                def announceInstance = Announce.get(params.id)
                if(!announceInstance)
                    respond([message:"Announce doesnt exist"], status: 404)
                Announce.withTransaction {
                    announceInstance.delete()
                }
                respond([message:"Announce successfully deleted"], status: 200)

                if(!announceInstance.delete())
                    respond([message:"Announce cannot be deleted"], status: 204)
                break;
            default:
                break;
        }
    }

    def announces()
    {
        switch(request.getMethod())
        {
            case "GET":
                def announcesList = Announce.getAll()
                if(!announcesList)
                    return response.status = 404
                //return response.status = 200
                renderAnnounces(announcesList, request.getHeader('Accept'))
                break;
            case "POST":
                //2 find user
                //3 create new announce
                //convert image to binary? pass image through multipart/form-data
                //when? send image and data at the same time? create data then go through update to send image


                def newAnnounceInstance
                def user

                //header: accept application/json
                if(!request.JSON.username){
                    if(!User.get(request.JSON.userid))
                        respond([message:"can't find user id for new announce"], status: 400)
                    else
                        user = User.findById(request.JSON.userid)
                }
                else
                {
                    if(!User.findByUsername(request.JSON.username))
                        respond([message: "can't find username for new announce"], status: 400)
                    else
                        user = User.findByUsername(request.JSON.username)
                }

                Announce.withTransaction {
                    newAnnounceInstance = new Announce(title: request.JSON.title,
                            description: request.JSON.description,
                            price: Float.parseFloat(request.JSON.price))
                    user.addToAnnounce(newAnnounceInstance)
                    user.save()
                }

                if(!request.JSON.title || !request.JSON.description || !request.JSON.price)
                //render(status: 400, text:"User couldn't be saved")
                    respond([message:"announce entities cannot be null"], status: 400)
                if(!newAnnounceInstance || !user)
                    return response.status = 404
                return response.status = 201
                //renderThis(newAnnounceInstance, request.getHeader('Accept'))
                break;
        }

    }

    def addillus(){
        if(!params.id) {
            respond([message: "Invalid announce id"], status: 400)
            return
        }
        def announceInstance = Announce.get(params.id)
//        def image = request.JSON.filename
//        def imagesize = request.JSON.size
//        announceInstance.addToIllustrations(new Illustration(filename: image, size: imagesize))
//        announceInstance.save()
        if(uploadService.upload(announceInstance, request)) {
            respond([message: "Illustration successfully added"], status: 200)
            return
        }
        else
        {
            respond([message: "Invalid addition of illustration"], status: 400)
            return
        }
    }

    def illustration()
    {
        switch (request.getMethod())
        {
            case "PATCH":
                break;
            case "DELETE":
                if(!params.id)
                    respond([message:"Invalid illustration id"], status: 400)
                def illustrationInstance = Illustration.get(params.id)
                def announceInstance = illustrationInstance.announce
                Announce.withTransaction {
                    announceInstance.removeFromIllustrations(illustrationInstance)
                    announceInstance.save()
                    illustrationInstance.delete()
                }
                respond([message:"Illustration successfully deleted"], status: 200)
                break;
        }
    }

    def renderUser(User instance, String acceptHeader)
    {
        switch (acceptHeader)
        {
            case "json":
            case "application/json":
            case "text/json":
                render instance as JSON
                return
                break;

            case "xml":
            case "application/xml":
            case "text/xml":
                render instance as XML
                return
                break;

            default:
                return response.status = 406
        }
    }

    def renderAnnounce(Announce instance, String acceptHeader)
    {
        switch (acceptHeader)
        {
            case "json":
            case "application/json":
            case "text/json":
                render instance as JSON
                return
                break;

            case "xml":
            case "application/xml":
            case "text/xml":
                render instance as XML
                return
                break;

            default:
                return response.status = 406
        }
    }

    def renderUsers(List<User> users, String acceptHeader)
    {
        switch (acceptHeader)
        {
            case "json":
            case "application/json":
            case "text/json":
                render users as JSON
                return
                break;

            case "xml":
            case "application/xml":
            case "text/xml":
                render users as XML
                return
                break;

            default:
                return response.status = 406
        }
    }

    def renderAnnounces(List<Announce> announces, String acceptHeader)
    {
        switch (acceptHeader)
        {
            case "json":
            case "application/json":
            case "text/json":
                render announces as JSON
                return
                break;

            case "xml":
            case "application/xml":
            case "text/xml":
                render announces as XML
                return
                break;

            default:
                return response.status = 406
        }
    }
}
