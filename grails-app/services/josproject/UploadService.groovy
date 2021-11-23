package josproject

import grails.gorm.transactions.Transactional
import org.apache.commons.lang.RandomStringUtils
import org.springframework.web.multipart.MultipartHttpServletRequest

import javax.servlet.http.HttpServletRequest

@Transactional
class UploadService {
    def grailsApplication
    def upload(Announce announce,MultipartHttpServletRequest request) {
        def f = request.getFile('payload')
        if (f.empty) {
            return announce
        }

        String illusVariable = RandomStringUtils.random(16, true, true)

        //f.transferTo(new File(grailsApplication.config.assets.path + illusVariable))
        // render(status: 200, text: 'Done')
        //response.sendError(200, 'Done')
        String image = FileUtil.uploadAnnounceImage(illusVariable, request.getFile("payload"))
        if (!image.equals("")) {
            announce.addToIllustrations(new Illustration(filename: image))
            println("illustration affectée")
            announce.save()
            return announce
        }
    }
}

/*
    def uploadImage( Announce announce, MultipartHttpServletRequest request){
        if(request.getFile('payload') && !request.getFile("payload").originalFilename.equals("")){
            String image = FileUtil.uploadAnnounceImage(announce.id,request.getFile("payload"))
            if(!image.equals("")){
                announce.addToIllustrations(new Illustration(filename: image))
                announce.save(flush : true)
            }
        }
    }

 */
