/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit

class TopMediaController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBInspectable var feedURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string: feedURL)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
            if let jsonData = data,
                let feed = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary,
                let title = feed.value(forKeyPath: "feed.entry.im:name.label") as? String,
                let artist = feed.value(forKeyPath: "feed.entry.im:artist.label") as? String,
                let imageURLs = feed.value(forKeyPath: "feed.entry.im:image") as? [NSDictionary] {
                    if let imageURL = imageURLs.last,
                        let imageURLString = imageURL.value(forKeyPath: "label") as? String {
                            self.loadImageFromURL(URL(string:imageURLString)!)
                    }
                self.titleLabel.text = title
                self.titleLabel.isHidden = false
                self.artistLabel.text = artist
                self.artistLabel.isHidden = false
                
            }
        }
    }
    
    func loadImageFromURL(_ URL: Foundation.URL) {
        let request = URLRequest(url: URL)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
            if let imageData = data {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
}
