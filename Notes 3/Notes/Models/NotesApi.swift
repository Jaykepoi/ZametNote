//
//  NotesApi.swift
//  Notes
//
//  Created by Mikhail Kim on 06.12.2021.
//

import Foundation

class NotesApi {
    
    static let shared = NotesApi()
    
    let baseUrl = "https://www.zametochnik.ru"
    var tokenInfo: TokenInfo?
    
    
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let params = ["email": email, "password": password]
        
        let urlString = baseUrl + "/api/token/"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            
            if let responseData = data,
               (200..<300).contains(urlResponse.statusCode) {
                
                do {
                    let decoder = JSONDecoder()
                    self.tokenInfo = try decoder.decode(TokenInfo.self, from: responseData)
                    completion(true)
                } catch {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    func registerUser(dict: [String: String],
                      completion: @escaping (Bool) -> Void) {
        
        
        let urlString = baseUrl + "/api/users/"
        
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: dict, options: [])
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let urlResponse = response as? HTTPURLResponse else {
                    completion(false)
                    return
                }
                
                if let responseData = data,
                   (200...299).contains(urlResponse.statusCode) {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }.resume()
    }
    
    func getNoteList(completion: @escaping ([Note]?) -> Void) {
        let urlString = baseUrl + "/api/notes/"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        guard let token = tokenInfo?.access else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(nil)
                return
            }
            
            if let responseData = data, urlResponse.statusCode == 200 {
                do {
                    
                    let decoder = JSONDecoder()
                    let notes = try decoder.decode([Note].self, from: responseData)
                    completion(notes)
                } catch (let err) {
                    completion(nil)
                    print(err.localizedDescription)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
        
    }
    
    func saveNote(_ newNote: NewNote, completion: @escaping (Bool) -> Void) {
        let urlString = baseUrl + "/api/notes/"
        
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        guard let token = tokenInfo?.access else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try? encoder.encode(newNote)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            
            if urlResponse.statusCode == 201 {
                completion(true)
            } else {
                completion(false)
            }
        }
        task.resume()
        
    }
    
    func updateNote(id: String,
                    note: UpdateNote,
                    removeNote: Bool = false,
                    completion: @escaping (Bool) -> Void) {
        
        var note = note
        
        note.isActive = !removeNote
        
        let urlString = baseUrl + "/api/notes/\(id)/"
        
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        guard let token = tokenInfo?.access else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        
        
        request.httpBody = try? JSONEncoder().encode(note)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            
            if (200...299).contains(urlResponse.statusCode) {
                completion(true)
            } else {
                completion(false)
            }
        }
        task.resume()
        
    }
    
    func putNotes(_ Notes: PutNote, completion: @escaping (NoteDto?) -> Void) {
        let urlString = baseUrl + "/api/notes/{id}/"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        guard let token = tokenInfo?.access else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(nil)
                return
            }
            
            if let responseData = data, urlResponse.statusCode == 200 {
                do {
                    
                    let decoder = JSONDecoder()
                    let note = try decoder.decode(NoteDto?.self, from: responseData)
                    completion(note)
                } catch (let err) {
                    completion(nil)
                    print(err.localizedDescription)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
        
    }
    
}
