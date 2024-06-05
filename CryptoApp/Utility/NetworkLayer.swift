
//  Created by Mohamed Ali on 05/03/2024.


import Foundation
import Combine

/*
 
 **** func downloadData
 1- حددنا نوع الارجاع في الدالة الأولى عن طريق استدعاء دالة في مكتبة كومابين وهي
 eraseToAnyPublisher()
وهي بترجع اي نوع بابلشر
 AnyPublisher<Data,Error>
 
 
 
 **** func handelURLResponse
 ١- هي عبارة عن التأكد من ان البيانات بترجع بشكل سليم او بيرجع خطأ
 
 ٢- نوع الارجاع في الدالة هايكون
 throws Data
 لأنها ممكن ترجع داتا أو ايرور
 
 ٣- الدالة هاتستقبل ٢ بارامتر
 الاول
 URLSession.DataTaskPublisher.Output
 وهو دا اللى هايرجع الداتا في حال نحجت العملية وهايرجع خطأ في حال الفشل
 output(data,response)
 
 لما استدعينا الدالة بلا من استخدام
 .tryMap
 كتبنا
 try
 قبل اسم الدالة لان الدالة بتعمل ثرو وممكن ترجع خطأ
 
 
 **** func handelSinkComletion
 حددنا نوع البارامتر والارجاع في الدالة من خلال استدعائها قبل علمية الديكود

 الدالة بتستقبل بارمتر من نوع
 Subscribers.Completion<Error>
 وبترجع void
 بنعلم سويتش على البارمتر في حالة النجاح والفشل
 
 */

class NetworkManager {
    
    // create localize error enum
    enum NetworkError : LocalizedError{
        case badURLResponse(url:URL)
        case unkown
        
        var errorDescription: String {
            switch(self){
            case .badURLResponse(url: let url):
                return "bad URL Response from \(url)"
            case.unkown:
                return "UnKown Error"
            }
        }
    }
    
                  
    static func downloadData(url: URL) -> AnyPublisher<Data,Error> {
       return  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handelURLResponse(output:$0,url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    
    static func handelURLResponse(output: URLSession.DataTaskPublisher.Output,url:URL) throws -> Data{
        guard
            let response = output.response as? HTTPURLResponse ,
            response.statusCode >= 200 && response.statusCode < 300 else{
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }
    
    
    static func handelSinkCompletion(completion: Subscribers.Completion<Error>){
        switch(completion){
        case.finished:
            break
        case.failure(let error):
            print(error.localizedDescription)
        }
    }
}


