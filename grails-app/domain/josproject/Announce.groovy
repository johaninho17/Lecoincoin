package josproject

class Announce {

    String title
    String description
    Date dateCreated
    Date lastUpdated
    Float price

    static hasMany = [illustrations: Illustration]
    static belongsTo = [author: User]

    static constraints = {
        title nullable: false, blank: false, minSize: 5
        description nullable: false, blank: false
        price nullable: false, scale: 2, min: 0F

    }
    static mapping ={
        description type: 'text'
    }
}
