package josproject

import grails.gorm.transactions.Transactional
import grails.util.Holders
import org.apache.commons.lang.RandomStringUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

@Transactional
class FileUtil {

    def grailsApplication

    public static String getRootPath(){
        return Holders.grailsApplication.config.assets.path ;
    }


    public static String uploadAnnounceImage(String image, MultipartFile multipartFile){
        if(image != ""){
            String contactImagePath = getRootPath()
            multipartFile.transferTo(new File(contactImagePath,image))
            return image
        }
        return ""
    }
}
