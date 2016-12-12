//
//  ViewController.swift
//  DNDocumentDemo
//
//  Created by mainone on 16/12/9.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Home目录
        let homeDirectory = NSHomeDirectory()
        let documentPath = homeDirectory + "/Documents"
        let documentPath2 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        print("documentPath: \(documentPath) \n documentPath2: \(documentPath2)")
        /*
            苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包含此目录
         */
        
        
        // lib目录
        let LibraryPath = homeDirectory + "/Library/"
        let libraryPath2 = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
        print("LibraryPath: \(LibraryPath) \n LibraryPath2: \(libraryPath2)")
        /*
         这个目录下有2个子目录：Caches缓存 , Preferences偏好设置,不应该直接创建偏好设置文件而使用NSUserDefaults类
         */
        
        // Caches目录
        let libraryCachesPath = homeDirectory + "/Library/Caches"
        let libraryCachesPath2 = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        print("libraryCachesPath: \(libraryCachesPath) \n libraryCachesPath2: \(libraryCachesPath2)")
        /*
            主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出时删除
         */
        
        
        // temp目录
        let temp = homeDirectory + "/tmp"
        let temp2 = NSTemporaryDirectory()
        print("temp: \(temp) \n temp2: \(temp2)")
        /*
            用于存放临时文件，保持应用程序再次启动过程中不需要的信息，重启后清空
         */
       
        
        // 文件操作
        let fileManager = FileManager.default
        
        // 自定义存储位置
        let customDir = NSHomeDirectory() + "/Documents/customInfo"
        do {
            try fileManager.createDirectory(atPath: customDir, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("创建文件失败: \(error)")
        }
        /*
            withIntermediateDirectories设置为true表示中间目录不存在都会自动创建
         */
        
        // 保存文本信息到目录中
        let customInfo = "xiaozhuzhu222"
        let customTxtPath = customDir + "/customTxt.txt"
        do {
            try customInfo.write(toFile: customTxtPath, atomically: true, encoding: .utf8)
        } catch {
            print("写入文本失败: \(error)")
        }
        
        // 保存数组到目录中
        let customArray = ["OC", "Swift", "Android", "JAVA", "iOS"] as NSArray
        let customArrayPath = customDir + "/array.plist"
        customArray.write(toFile: customArrayPath, atomically: true)
        
        // 保存字典到目录
        let customDict = ["name": "xiaoxiong", "age": 18] as NSDictionary
        let customDictPath = customDir + "/dict.plist"
        customDict.write(toFile: customDictPath, atomically: true)
        
        // 保存data到目录中
        let image = UIImage(named: "sfa.png")
        if let image = image {
            let customData = UIImageJPEGRepresentation(image, 0.5)
            do {
                let customDataPath = customDir + "/data.jpg"
                let dataUrl = URL(fileURLWithPath: customDataPath)
                try customData?.write(to: dataUrl)
            } catch {
                print("保存Data失败: \(error)")
            }
        }
        
        
        // 判断目录是否存在
        let isExist = fileManager.fileExists(atPath: customTxtPath)
        guard isExist else {
            print("文件不存在")
            return;
        }
        
        // 移动文件内容
        let targetPath = customDir + "/target.txt"
        
        do {
            try fileManager.moveItem(atPath: customTxtPath, toPath: targetPath)
        } catch {
            print("移动失败: \(error)")
        }
        
        // 获取目录下的所有文件
        let fileArray = fileManager.subpaths(atPath: customDir)
        print("customInfo目录下的所有文件: \(fileArray)")
        
        // 删除文件
        do {
            try fileManager.removeItem(atPath: targetPath)
        } catch {
            print("删除文件失败: \(error)")
        }
        
        // 删除目录下的所有文件
        do {
            try  fileArray?.forEach({ (item) in
                try fileManager.removeItem(atPath: customDir + "/\(item)")
            })
        } catch  {
            print("删除失败: \(error)")
        }
       
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

