/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit

class TopMediaController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBInspectable var titleText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let feedURL = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=1/json"
        let request = NSURLRequest(URL: NSURL(string: feedURL)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { response, data, error in
            if let jsonData = data,
                feed = (try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)) as? NSDictionary,
                title = feed.valueForKeyPath("feed.entry.im:name.label") as? String,
                artist = feed.valueForKeyPath("feed.entry.im:artist.label") as? String {
                self.titleLabel.text = title
                self.titleLabel.hidden = false
                self.artistLabel.text = artist
                self.artistLabel.hidden = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
}
