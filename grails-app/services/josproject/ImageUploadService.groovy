package josproject

import grails.gorm.transactions.Transactional

@Transactional
class ImageUploadService {

    def imaageUpload() {
        def f = request.getFile('image')
        if (f.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'uploadForm')
            return
        }

        f.transferTo(new File('/grails-app/assets/images/image.png'))
        response.sendError(200, 'Done')
    }
}
