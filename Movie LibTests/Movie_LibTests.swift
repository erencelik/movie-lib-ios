//
//  Movie_LibTests.swift
//  Movie LibTests
//
//  Created by Eren on 28.08.2021.
//

import XCTest
@testable import Movie_Lib

class Movie_LibTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMovieAPIGetMovies() throws {
        
        self.measure {
            // Put the code you want to measure the time of here.
            MovieAPI.shared.getMovies("Hey") { response in
                XCTAssertEqual(response.movies?.isEmpty, false)
            } _: { error in
                XCTFail()
            }

        }
        
    }
    
    func testMovieParseJson() throws {
        
        let jsonString = "{\"adult\":false,\"backdrop_path\":\"/2bbJoYj95ruoIHbTa6Z51dPbbm0.jpg\",\"genre_ids\":[10751,35,16,12],\"id\":439058,\"original_language\":\"en\",\"original_title\":\"Hey Arnold! The Jungle Movie\",\"overview\":\"When their trip to San Lorenzo takes a turn for the worst, Arnold and his classmate’s only hope of getting home is retracing the dangerous path that led to Arnold's parents' disappearance.\",\"popularity\":19.352,\"poster_path\":\"/r42WcL8xjH3ThQywlSfWgoW4GOU.jpg\",\"release_date\":\"2017-11-23\",\"title\":\"Hey Arnold! The Jungle Movie\",\"video\":false,\"vote_average\":7.7,\"vote_count\":170}"
        
        XCTAssertNotNil(Movie(JSONString: jsonString))
        
    }
    
    func testMovieWatchedStateChange() throws {
        
        let jsonString = "{\"adult\":false,\"backdrop_path\":\"/2bbJoYj95ruoIHbTa6Z51dPbbm0.jpg\",\"genre_ids\":[10751,35,16,12],\"id\":439058,\"original_language\":\"en\",\"original_title\":\"Hey Arnold! The Jungle Movie\",\"overview\":\"When their trip to San Lorenzo takes a turn for the worst, Arnold and his classmate’s only hope of getting home is retracing the dangerous path that led to Arnold's parents' disappearance.\",\"popularity\":19.352,\"poster_path\":\"/r42WcL8xjH3ThQywlSfWgoW4GOU.jpg\",\"release_date\":\"2017-11-23\",\"title\":\"Hey Arnold! The Jungle Movie\",\"video\":false,\"vote_average\":7.7,\"vote_count\":170}"
        
        let movie = Movie(JSONString: jsonString)
        
        movie?.watched = true
        
        XCTAssertEqual(movie?.watched, true)
        
    }
    
    func testMovieWatchedStateToggle() throws {
        
        let jsonString = "{\"adult\":false,\"backdrop_path\":\"/2bbJoYj95ruoIHbTa6Z51dPbbm0.jpg\",\"genre_ids\":[10751,35,16,12],\"id\":439058,\"original_language\":\"en\",\"original_title\":\"Hey Arnold! The Jungle Movie\",\"overview\":\"When their trip to San Lorenzo takes a turn for the worst, Arnold and his classmate’s only hope of getting home is retracing the dangerous path that led to Arnold's parents' disappearance.\",\"popularity\":19.352,\"poster_path\":\"/r42WcL8xjH3ThQywlSfWgoW4GOU.jpg\",\"release_date\":\"2017-11-23\",\"title\":\"Hey Arnold! The Jungle Movie\",\"video\":false,\"vote_average\":7.7,\"vote_count\":170}"
        
        let movie = Movie(JSONString: jsonString)
        
        movie?.watched.toggle()
        
        XCTAssertEqual(movie?.watched, true)
        
    }

}
