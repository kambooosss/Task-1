//
//  Interacter.swift
//  Task1
//
//  Created by kamalesh-pt7513 on 21/02/24.
//

import Foundation
import UIKit

class Interacter: interactorDelegate {
    
    
    
    
    var presenter: presenterDelegate?
    
    func verifyCredential(username: String?, password: String?) {
        if let username = username{ //OP?
            if let user = UserDefaults.standard.data(forKey: username){
                do{
                    let decodedInstance = try JSONDecoder().decode(User.self, from: user)
                    if(decodedInstance.password == password){
                        print("logged In")
                        presenter?.showLoadingPage(user: decodedInstance)
                    }else{
                        print("wrong answer")
                    }
                }catch{
                    print("can't decode")
                }
            }
            else{
                print("Username doesnt exist")
            }
        }
        else{
            print("username cant be nil")
        }
    }
    
    func creatUser(username: String?, password: String?, age: Int?, country: String?, gender: String?) {
        guard let username = username else
        {
            print("user is empty")
            return
        }
        
        guard let password = password , validatePassword(password: password) else {
            print("password must contains atleast 6 letter, a speacial character, a capital letter")
            presenter?.weakPassword()
//            let alert = UIAlertController(title: "Aleart", message: "This is an alert.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil)

//            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        if let age = age, let country = country, let gender = gender, !CheckRedundancy(username: username){
            
            let user = User(username: username, country: country, age: age, gender: gender, password: password)
            do{
                let encodedData = try JSONEncoder().encode(user)
                UserDefaults.standard.set(encodedData,forKey: username)
                print("create new account succesfully")
                presenter?.showLoadingPage(user: user)
            }catch{
                print("error occured while creting user")
            }
        }else{
            print("either field is empty or already user exits")
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
        print("form inter the text it got is :k \(text)")
        user.listing.append(text)
        print("the user name we got is \(user.username)")
        print("then user list is : \(user.listing)")
        if let username = user.username{
            do{
                let encodedData = try JSONEncoder().encode(user)
                UserDefaults.standard.set(encodedData,forKey: username)
                print("added doclist succes fully")
                print(user.listing)
                
            }catch{
                print("erro in adding doclist")
            }
        }
        
    }
}
extension Interacter
{
    func fetchData() {
        guard let url = URL(string: "https://fake-json-api.mock.beeceptor.com/users") else {return}
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data , _ ,error in
            guard let data = data, error == nil else {
                self?.presenter?.didFetchData(result: .failure("not found" as! Error))
                return
            }
            
        
            do{
                let data = try JSONDecoder().decode([Names].self,from: data)
                print(data)
                self?.presenter?.didFetchData(result: .success(data))
            }catch{
                self?.presenter?.didFetchData(result: .failure("not found " as! Error))
            }
        }
        task.resume()
    }
    
}
