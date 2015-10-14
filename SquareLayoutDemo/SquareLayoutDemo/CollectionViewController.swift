import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

  var count = 0

  @IBAction func add(sender: AnyObject) {
    self.count++
    self.collectionView?.performBatchUpdates({ () -> Void in
      self.collectionView!.insertItemsAtIndexPaths([NSIndexPath(forItem: self.count - 1, inSection: 0)])
      }, completion: nil)
  }

  @IBAction func trash(sender: AnyObject) {

  }

  // MARK: UICollectionViewDataSource

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }


  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return count
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    return cell
  }
}
