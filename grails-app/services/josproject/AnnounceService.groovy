package josproject

import grails.gorm.services.Service

@Service(Announce)
interface AnnounceService {

    Announce get(Serializable id)

    List<Announce> list(Map args)

    Long count()

    void delete(Serializable id)

    Announce save(Announce announce)

}