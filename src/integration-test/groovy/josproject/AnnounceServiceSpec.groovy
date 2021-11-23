package josproject

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class AnnounceServiceSpec extends Specification {

    AnnounceService announceService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Announce(...).save(flush: true, failOnError: true)
        //new Announce(...).save(flush: true, failOnError: true)
        //Announce announce = new Announce(...).save(flush: true, failOnError: true)
        //new Announce(...).save(flush: true, failOnError: true)
        //new Announce(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //announce.id
    }

    void "test get"() {
        setupData()

        expect:
        announceService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Announce> announceList = announceService.list(max: 2, offset: 2)

        then:
        announceList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        announceService.count() == 5
    }

    void "test delete"() {
        Long announceId = setupData()

        expect:
        announceService.count() == 5

        when:
        announceService.delete(announceId)
        sessionFactory.currentSession.flush()

        then:
        announceService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Announce announce = new Announce()
        announceService.save(announce)

        then:
        announce.id != null
    }
}
