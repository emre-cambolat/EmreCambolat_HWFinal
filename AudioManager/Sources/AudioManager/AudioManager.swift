//
//  AudioService.swift
//  DictionaryApp
//
//  Created by Emre Cambolat on 1.06.2023.
//

import AVFoundation

public final class AudioManager: NSObject, AVAudioPlayerDelegate {
    // MARK: - Variables
    public static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?
    private var completionClosure: (() -> Void)?
    
    // MARK: - Functions
    private override init() {}
    
    public func downloadAndPlayAudio(from audioURL: String, completion: (() -> Void)?) {
        guard let url = URL(string: audioURL) else {
            print("Invalid Audio URL")
            return
        }
        
        self.completionClosure = completion
        
        downloadAudio(from: url) { result in
            switch result {
            case .success(let data):
                self.playAudio(with: data)
            case .failure(let error):
                print("Failed to download audio: \(error.localizedDescription)")
                self.completionClosure?() 
            }
        }
    }
    
    private func downloadAudio(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                let unknownError = NSError(domain: "AudioService", code: 0, userInfo: nil)
                completion(.failure(unknownError))
            }
        }
        task.resume()
    }
    
    private func playAudio(with data: Data) {
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()

        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
            self.completionClosure?()
        }
    }
    
    public func stopAudio() {
        audioPlayer?.stop()
        completionClosure?()
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            completionClosure?()
        }
}
