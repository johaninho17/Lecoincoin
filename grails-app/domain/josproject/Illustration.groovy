package josproject

class Illustration {

    String filename
    Integer size

    static belongsTo = [announce: Announce]

    static constraints = {
        filename nullable: false, blank: false
        size nullable: true, min: 0
    }
}
