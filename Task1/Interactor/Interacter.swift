//
//  Interacter.swift
//  Task1
//
//  Created by kamalesh-pt7513 on 21/02/24.
//

import Foundation
import UIKit

class Interacter: interactorDelegate {
    
    
    
    var url = URL(string: "https://fake-json-api.mock.beeceptor.com/users")
    var presenter: presenterDelegate?
    
    func verifyCredential(username: String?, password: String?) {
        if let username = username , username != "" { //OP?
            if let user = UserDefaults.standard.data(forKey: username){
                do{
                    let decodedInstance = try JSONDecoder().decode(User.self, from: user)
                    if(decodedInstance.password == password){
                        print("logged In")
                        presenter?.showLoadingPage(user: decodedInstance)
                    }else{
//                        print("wrong answer")
                        presenter?.showWarning(message: "Password is incorrect")
                    }
                }catch{
//                    print("can't decode")
                    presenter?.showWarning(message: "An error occured while decoding")
                }
            }
            else{
                print("Username doesnt exist")
                presenter?.showWarning(message: "Username doesnt exist try to sign up")
            }
        }
        else{
//            print("username cant be nil")
            presenter?.showWarning(message: "Username cant be nil")
        }
    }
    
    func creatUser(username: String?, password: String?, age: Int?, country: String?, gender: String?) {
        guard let username = username,username != "" else
        {
            presenter?.signupViewWarning(message: "user name cant be empty")
            return
        }
        if(CheckRedundancy(username: username)){
            presenter?.signupViewWarning(message: "user already exist try to login")
            return
        }
        guard let password = password , validatePassword(password: password) else {
            presenter?.signupViewWarning(message: "password must contains atleast 6 letter, a speacial character, a capital letter")
//            let alert = UIAlertController(title: "Aleart", message: "This is an alert.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil)

//            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        if let age = age, let country = country, let gender = gender {
            
            let user = User(username: username, country: country, age: age, gender: gender, password: password)
            do{
                let encodedData = try JSONEncoder().encode(user)
                UserDefaults.standard.set(encodedData,forKey: username)
                print("create new account succesfully")
                presenter?.showLoadingPage(user: user)
            }catch{
                presenter?.signupViewWarning(message: "error occured while creting user")
            }
        }else{
            presenter?.signupViewWarning(message: "all field are mandotory")
        }
    }
    func CheckRedundancy(username: String) -> Bool
    {
        return (UserDefaults.standard.object(forKey: username) != nil) ? true : false
    }
    func validatePassword(password: String) -> Bool
    {
        let reference = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        return reference.evaluate(with: password)
    }
    
    
}
extension Interacter{
    func addDocList(user: User, text: String) {
        
        user.listing.append(text)

        if let username = user.username{
            do{
                let encodedData = try JSONEncoder().encode(user)
                UserDefaults.standard.set(encodedData,forKey: username)
            }catch{
                return
            }
        }
        
    }
}
extension Interacter
{
    func fetchData() {
        guard let url = self.url else{return}
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data , _ ,error in
            guard let data = data, error == nil else {
                self?.presenter?.didFetchData(result: .failure(error as! Error))
                return
            }
            do{
                let data = try JSONDecoder().decode([Names].self,from: data)
                print(data)
                self?.presenter?.didFetchData(result: .success(data))
            }catch{
                self?.presenter?.didFetchData(result: .failure(error))
            }
        }
        task.resume()
    }
    
}
