class UserModel{
    /*
    * Name
    * Date Joined
    * Generate UID
    * email
    * password
    * phone
    * */
    constructor(name,email,password,phone,uid) {
        this.email = email
        this.name = name
        this.password=password
        this.phone=phone
        this.uid =uid
    }

    get user_data(){
        console.log("Returns the user data")
        return  `
        {
        name:${this.name
        },
        email:${this.email},
        password:${this.password},
        phone:${this.phone},
        uid:${this.uid}
        `
    }

    get userJson(){
        // Used to return the user data
        return {
            name: this.name,
            password: this.password,
            email: this.password,
            phone: this.phone
        }
    }
}