//
//  SavedCitiesViewController.m
//  FironetTestTask
//
//  Created by Vadim Orlov on 18.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import "SavedCitiesViewController.h"

@interface SavedCitiesViewController ()

@property (nonatomic, strong) SavedCitiesPresenter *savedCitiesPresenter;

@end

@implementation SavedCitiesViewController

#pragma mark - Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializePresenter];
}

#pragma mark - Initializers
- (void)initializePresenter {
    SavedCitiesService *savedCitiesService = [[SavedCitiesService alloc] init];
    SavedCitiesRouter *savedCitiesRouter = [[SavedCitiesRouter alloc] initWithController:self];
    self.savedCitiesPresenter = [[SavedCitiesPresenter alloc] initWithService:savedCitiesService
                                                                    andRouter:savedCitiesRouter];
    [self.savedCitiesPresenter attachView:self];
    [self.savedCitiesPresenter loadCities];
}

- (IBAction)addNewCity:(UIBarButtonItem *)sender {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Search For City"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter City Name";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          NSString *cityToFind = alert.textFields.firstObject.text;
                                                          if (cityToFind.length > 0) {
                                                              [self.savedCitiesPresenter addCityWithName:cityToFind
                                                                                           andComplition:^(BOOL finished) {
                                                                                               [weakSelf citiesLoaded];
                                                                                           }];
                                                          } else {
                                                              NSLog(@"===== THE FIELD IS EMPTY =====");
                                                          }
                                                      }];
    [alert addAction:cancelAction];
    [alert addAction:addAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 122;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedCitiesPresenter.cities.count;
}

- (CityTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CITY_TABLE_VIEW_CELL_ID forIndexPath:indexPath];
    CityViewData *city = self.savedCitiesPresenter.cities[indexPath.row];
    [cell configureWithCity:city];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.savedCitiesPresenter.router openDetailInfoForCity:self.savedCitiesPresenter.cities[indexPath.row]];
}


#pragma mark - SavedCitiesView

- (void)citiesLoaded {
    [self.tableView reloadData];
}

@end
