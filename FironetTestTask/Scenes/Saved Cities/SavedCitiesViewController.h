//
//  SavedCitiesViewController.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 18.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavedCitiesPresenter.h"
#import "CityTableViewCell.h"

@interface SavedCitiesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SavedCitiesView>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
