//
//  Untitled.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 23/02/25.
//

///We have two server 1. Test server and other is Prod server. So we need to run different configuration for different targets..
public struct CloudStorageDefaultURL {
    // Default base URL for CRM Cognito
    ///https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com/o/watchface%2Fgt01%2Fprod%2Fimages%2Flocal_1.png?alt=media&token=06535626-6390-453f-b4d6-6ab82958a0b5
    //watchface/id207/prod/images/watch.png
    static let test = "https://firebasestorage.googleapis.com:443/v0/b/vestel-aida-test.appspot.com"
    ///https://firebasestorage.googleapis.com:443/v0/b/vestel-aida-test.appspot.com/o/watchface%2Fid207%2Ftest%2Fimages%2Fwatch.png?alt=media&token=0e8e3ad5-0f03-45cc-94ba-9af7d8d191bc
    //watchface/id207/test/images/watch.png
    static let prod = "https://firebasestorage.googleapis.com:443/v0/b/vestel-aida.appspot.com"
    ///It'll use to download URL at every launch
    static let sampleFile = "watchface/default/defaultWallpaper.png"
    ///It'll use to download custom wallpaper  for V3
    static let customWallpaperFile = "watchface/gtx12/prod/custom_wallpaper/custom_wallpaper.zip"
}
