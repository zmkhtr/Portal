//
//  Post.swift
//  Portal
//
//  Created by Dedy Yuristiawan on 27/07/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import Foundation
import CloudKit

class Post: CloudKitProtocol, Identifiable, Equatable {
    
    public var record: CKRecord?
    var id: CKRecord.ID?
    var title: String?
    var viewer: Int?
    var lpm: Double?
    var video : CKAsset?
    var videoUrl : URL?
    var isSensitiveContent: Int?
    var userReference : CKRecord.Reference?
    var isLive: Int?
    
    static var RecordType = "Post"
    
    public required init(ckRecord: CKRecord) {
        self.title = ckRecord["title"]
        self.viewer = ckRecord["viewer"]
        self.lpm = ckRecord["lpm"]
        self.video = ckRecord["video"]
        self.isSensitiveContent = ckRecord["isSensitiveContent"]
        self.userReference = ckRecord["userReference"]
        self.isLive = ckRecord["isLive"]
        
        self.record = ckRecord
        self.id = ckRecord.recordID
    }
    
    init(title: String?, viewer: Int?, lpm: Double?, videoUrl: URL, isSensitiveContent: Int?, isLive: Int?, userReference: CKRecord.Reference?){
        self.title = title
        self.viewer = viewer
        self.lpm = lpm
        self.isSensitiveContent = isSensitiveContent
        self.video = CKAsset(fileURL: videoUrl)
        self.videoUrl = videoUrl
        self.userReference = userReference
        self.isLive = isLive
        
        if record == nil {
            record = CKRecord(recordType: Self.recordType)
        }
        
        record?["title"] = title
        record?["viewer"] = viewer
        record?["lpm"] = lpm
        record?["video"] = CKAsset(fileURL: videoUrl)
        record?["isSensitiveContent"] = isSensitiveContent
        record?["isLive"] = isLive
        record?["userReference"] = userReference
        
        if let record = self.record {
            self.id = record.recordID
        }
    }
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    
}
