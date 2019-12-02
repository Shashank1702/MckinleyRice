//
//  HCImageDL.swift
//
//  Created by Hypercube on 8/30/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit
import SDWebImage

public enum SDImageOptionType
{
    case RetryFailed
    case LowPriority
    case CacheMemoryOnly
    case ProgressiveDownload
    case RefreshCached
    case ContinueInBackground
    case HandleCookies
    case AllowInvalidSSLCertificates
    case HighPriority
    case DelayPlaceholder
    case TransformAnimatedImage
    case AvoidAutoSetImage
    case ScaleDownLargeImages
}

open class HCImageDL: NSObject {
    
    public static let shared: HCImageDL = {
        
        let instance = HCImageDL()
        
        return instance
    }()

    /// Download and set image in imageView from specified URL with some specific options,
    /// and possibility to set Progress Indicator and completion function when image is set.
    ///
    /// - Parameters:
    ///   - imageView: UIImageView where image will set
    ///   - url: URL image source
    ///   - placeholder: Name of placeholder image. Default value is "placeholder".
    ///   - showProgressIndicator: Defines is Progress Indicator shown. Default value is false.
    ///   - options: SDImageOptionType values. By default, this array is empty.
    ///   - completed: Function that runs when the image is set. Default completion function is not set.
    public func setImageFromURL(imageView:UIImageView, url: String, placeholder: String = "placeholder", showProgressIndicator: Bool = false, options: [SDImageOptionType] = [], completed:((UIImage,Bool) -> Swift.Void)? = nil)
    {
        if showProgressIndicator
        {
            //imageView.sd_setShowActivityIndicatorView(true)
            //imageView.sd_setIndicatorStyle(.gray)
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        }
        
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: placeholder),options:makeOptionsArrayForImage(options),completed: {
            (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
            if error != nil
            {
                print(error?.localizedDescription as Any)
            } else if completed != nil && image != nil {
                if cacheType == SDImageCacheType.none
                {
                    completed!(image!,false)
                } else {
                    completed!(image!,true)
                }
            }
        })
    }

    /// Download image from specified URL with some specific options, and possibility to set completion function.
    ///
    /// - Parameters:
    ///   - url: URL image source
    ///   - options: SDImageOptionType values. By default, this array is empty.
    ///   - completed: Function that runs when the image is downloaded. Default completion function is not set.
    public func downloadImageFromURL(url: String, options: [SDImageOptionType] = [], completed:((UIImage,Bool) -> Swift.Void)? = nil)
    {
        let manager = SDWebImageManager.shared
        manager.loadImage(with: URL(string: url),
                          options: makeOptionsArrayForImage(options),
                          progress: {
                            (receivedSize: Int, expectedSize: Int, url: URL?) in
                            //print("\(receivedSize)" + "/" + "\(expectedSize)")
        },completed: {
            (image: UIImage?, data: Data?, error: Error?, cacheType: SDImageCacheType, finished: Bool, imageURL: URL?) in
            if error != nil
            {
                print(error?.localizedDescription as Any)
            } else if completed != nil && image != nil {
                if cacheType == SDImageCacheType.none
                {
                    completed!(image!,false)
                } else {
                    completed!(image!,true)
                }
            }
        })
    }
    
    /// Remove Image with specified URL from cache, or and from Disk if it is specified. Also this function have possibility to set completion function.
    ///
    /// - Parameters:
    ///   - url: URL image source
    ///   - removeFromDisk: Defines whether the image will be deleted from Disk. Default value is true.
    ///   - completed: Function that runs when the image is deleted. Default completion function is not set.
    public func removeImageFromCache(url: String, removeFromDisk: Bool = true, completed:(() -> Swift.Void)? = nil)
    {
        let cache = SDImageCache.shared
        cache.removeImage(forKey: url, fromDisk:removeFromDisk, withCompletion: {() in
            
            if completed != nil
            {
                completed!()
            }
        })
    }
    
    /// Remove all Images from cache. Also this function have possibility to set completion function. Default completion function is not set.
    ///
    /// - Parameter completed: Function that runs when all images are deleted. Default completion function is not set.
    public func removeAllImagesFromCache(completed:(() -> Swift.Void)? = nil)
    {
        let cache = SDImageCache.shared
        cache.clearDisk(onCompletion: {() in
            
            if completed != nil
            {
                completed!()
            }
        })
        cache.clearMemory()
    }
    
    /// Convert SDImageOptionType enumeration values array to SDWebImageOptions array
    ///
    /// - Parameter options: SDImageOptionType enumeration values array
    /// - Returns: Converted SDWebImageOptions array
    public func makeOptionsArrayForImage(_ options: [SDImageOptionType]) -> SDWebImageOptions
    {
        if options == []
        {
            return []
        }
        var readyOptions: SDWebImageOptions = []
        for option in options
        {
            switch option {
            case .RetryFailed:
                readyOptions.insert(SDWebImageOptions.retryFailed)
            case .LowPriority:
                readyOptions.insert(SDWebImageOptions.lowPriority)
            case .CacheMemoryOnly:
                print("No option CacheMemoryOnly")
                //readyOptions.insert(SDWebImageOptions.cacheMemoryOnly)
            case .ProgressiveDownload:
                readyOptions.insert(SDWebImageOptions.progressiveLoad)
            case .RefreshCached:
                readyOptions.insert(SDWebImageOptions.refreshCached)
            case .ContinueInBackground:
                readyOptions.insert(SDWebImageOptions.continueInBackground)
            case .HandleCookies:
                readyOptions.insert(SDWebImageOptions.handleCookies)
            case .AllowInvalidSSLCertificates:
                readyOptions.insert(SDWebImageOptions.allowInvalidSSLCertificates)
            case .HighPriority:
                readyOptions.insert(SDWebImageOptions.highPriority)
            case .DelayPlaceholder:
                readyOptions.insert(SDWebImageOptions.delayPlaceholder)
            case .TransformAnimatedImage:
                readyOptions.insert(SDWebImageOptions.transformAnimatedImage)
            case .AvoidAutoSetImage:
                readyOptions.insert(SDWebImageOptions.avoidAutoSetImage)
            case .ScaleDownLargeImages:
                readyOptions.insert(SDWebImageOptions.scaleDownLargeImages)
            }
        }
        return readyOptions
    }
}
