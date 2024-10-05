import UIKit


class Person {
    
    deinit {
        print("Person deinit")
    }
}

//Here we are creating a strong reference by referencing to the instance of the class(object)
var person: Person? = Person()             //count = 1

var Anna: Person? = person                 // count + 1
var John: Person? = person                 // count + 1


Anna = nil                                 //count - 1
John = nil                                 //count - 1

person = nil                                //count = 0 // deallocated from memory



//weak reference
weak var person2: Person? = Person()  // if person2 has weak reference, object and the weak references related to object will be deallocated immediately
print("person2 is deallocated")


//unowned reference
unowned var person3: Person? = Person()  // if person3 has unowned reference, only object will be deallocated immediately and not the weak references related to object and it will not increase the count, it might lead to a crash(less safe)
print("person2 is deallocated")





//Memory Leak - resolved by using weak reference

class Tenant {
    var name: String
    var apartment: Apartment?

    init(name: String) {
        self.name = name
    }
    deinit {
        print("Tenant deallocated")
    }
}

class Apartment {
    //var tenant: Tenant?
    weak var tenant: Tenant? // Change to weak reference
    init(tenant: Tenant) {
        self.tenant = tenant
    }
    deinit {
        print("Apartment deallocated")
    }
}

// Creating instances
var john: Tenant? = Tenant(name: "John")
var johnsApartment: Apartment? = Apartment(tenant: john!)

john?.apartment = johnsApartment

// If it is not set to weak, At this point, both john and johnsApartment are strongly referencing each other,
// creating a reference cycle.

john = nil
johnsApartment = nil // Neither will be deinitialized due to the cycle if it is not declared as weak
print("End of program")





//Unowned Example

class University {
    var name: String

    init(name: String) {
        self.name = name
    }
    deinit {
        print("University deallocated")
    }
}

class Student {
    unowned var university: University // unowned reference

    init(university: University) {
        self.university = university
    }
    
    deinit {
        print("Student deallocated")
    }
}

// Usage
let harvard = University(name: "Harvard")
let student = Student(university: harvard)


// It is guaranteed that the university will outlive the student.

print("End of program")

