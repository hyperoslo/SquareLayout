import UIKit

var kItemSize: CGFloat = 100.0

class SquareLayout: UICollectionViewLayout {
  lazy var dynamicAnimator: UIDynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
  var gravityBehavior: UIGravityBehavior = UIGravityBehavior()
  var collisionBehabior: UICollisionBehavior = UICollisionBehavior()

  // MARK: Initialization

  override init() {
    super.init()
    dynamicAnimator.addBehavior(gravityBehavior)
    dynamicAnimator.addBehavior(collisionBehabior)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    dynamicAnimator.addBehavior(gravityBehavior)
    dynamicAnimator.addBehavior(collisionBehabior)
  }

  // MARK: CollectionView Layout

  override func collectionViewContentSize() -> CGSize {
    //return self.collectionView!.contentSize
    return UIScreen.mainScreen().bounds.size
  }

  override func prepareForCollectionViewUpdates(updateItems: [UICollectionViewUpdateItem]) {
    super.prepareForCollectionViewUpdates(updateItems)

    updateItems.filter{ $0.updateAction == .Insert }.forEach{
      let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: $0.indexPathAfterUpdate)
      attributes.frame = CGRectMake(CGRectGetMaxX(self.collectionView!.frame) + kItemSize, 300, kItemSize, kItemSize)

      let attachmentBehavior = UIAttachmentBehavior(item: attributes, attachedToAnchor: CGPointMake(CGRectGetMidX(self.collectionView!.bounds), 64))
      attachmentBehavior.length = 300.0
      attachmentBehavior.damping = 0.4
      attachmentBehavior.frequency = 1.0

      dynamicAnimator.addBehavior(attachmentBehavior)

      gravityBehavior.addItem(attributes)
      collisionBehabior.addItem(attributes)
    }
  }

  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return dynamicAnimator.itemsInRect(rect) as? [UICollectionViewLayoutAttributes]
  }

  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    return dynamicAnimator.layoutAttributesForCellAtIndexPath(indexPath)
  }
}
