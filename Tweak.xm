#import <UIKit/UIKit.h>

@interface UIApplication (k10)
-(BOOL) RemoveItemAtPath:(NSString *)RemoveItemAtPath;
-(void)deleteUserAction;
-(void)newAlert;
@end

static UIViewController *_topMostController(UIViewController *cont) {
    UIViewController *topController = cont;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    if ([topController isKindOfClass:[UINavigationController class]]) {
        UIViewController *visible = ((UINavigationController *)topController).visibleViewController;
        if (visible) {
            topController = visible;
        }
    }
    return (topController != cont ? topController : nil);
}
static UIViewController *topMostController() {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *next = nil;
    while ((next = _topMostController(topController)) != nil) {
        topController = next;
    }
    return topController;
}

%hook UIApplication
-(void)finishedTest:(id)arg1 extraResults:(id)arg2 {

  %orig;
  [self newAlert];
//   if (![[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLaunch"]) {
  


//   }
//   NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"fc_uuidForDevice"];

//   UIAlertController *alert = [UIAlertController alertControllerWithTitle:uuid message:nil preferredStyle:UIAlertControllerStyleAlert];

//     UIAlertAction *twitter = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//     // Open URL 
//     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/ajbbocydia"] options:@{} completionHandler:nil];
    
//     // // // //
//       [[NSUserDefaults standardUserDefaults] setValue:@"AlreadyLaunch" forKey:@"FirstLaunch"];
//       [[NSUserDefaults standardUserDefaults] synchronize];
//      }];
     
//     UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//       [[NSUserDefaults standardUserDefaults] setValue:@"AlreadyLaunch" forKey:@"FirstLaunch"];
//       [[NSUserDefaults standardUserDefaults] synchronize];
//      }];

//     [alert addAction:twitter];
//     [alert addAction:dismiss];

//     [topMostController() presentViewController:alert animated:true completion:nil];



 }
%new
 -(BOOL) RemoveItemAtPath:(NSString *)RemoveItemAtPath {
    
    NSFileManager *FileManager = [NSFileManager defaultManager];
    NSError *error;
    
    bool Success = [FileManager removeItemAtPath:RemoveItemAtPath error:&error];
    
    return Success;
}
%new
-(void)deleteUserAction{
    //  NSString *libraryPath = [NSString stringWithFormat:@"%@/Library", NSHomeDirectory()];
    NSString *prefsPath = [NSString stringWithFormat:@"%@/Library/Preferences/", NSHomeDirectory()];
    NSString *directoryPath = [NSHomeDirectory() stringByAppendingString:@"/Library/"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:directoryPath]) {
                NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:directoryPath];
                NSString *documentsName;
                while (documentsName = [dirEnum nextObject]) {
                    NSString *filePath = [directoryPath stringByAppendingString:documentsName];
                    BOOL isFileDeleted = [fileManager removeItemAtPath:filePath error:nil];
                    if(isFileDeleted == NO) {
                        // NSLog(@"All Contents not removed");
                        break;
                    }
                }
                // NSLog(@"All Contents Removed");
            }
    if ([fileManager fileExistsAtPath:prefsPath]) {
                NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:prefsPath];
                NSString *documentsName;
                while (documentsName = [dirEnum nextObject]) {
                    NSString *filePath = [prefsPath stringByAppendingString:documentsName];
                    BOOL isFileDeleted = [fileManager removeItemAtPath:filePath error:nil];
                    if(isFileDeleted == NO) {
                     
                        break;
                    }
                }
  
            }
    
    [[NSUserDefaults standardUserDefaults] setValue:@"88ecc8191e0a4849a413f675df106d3c" forKey:@"fc_uuidForDevice"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"fc_uuidForDevice"];
  
}
%new

-(void)newAlert{
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"fc_uuidForDevice"];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:uuid message:nil preferredStyle:UIAlertControllerStyleAlert];

      UIAlertAction *twitter = [UIAlertAction actionWithTitle:@"delete User" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      // Open URL
          [self deleteUserAction];
      
      // // // //
    
       }];
       
      UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
       }];

//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//
//
//        textField.keyboardType = UIKeyboardTypeDefault;
//        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        [textField resignFirstResponder];
//
//
//    }];
      [alert addAction:twitter];
      [alert addAction:dismiss];
 		
	  [topMostController() presentViewController:alert animated:true completion:nil];
	  }

%end