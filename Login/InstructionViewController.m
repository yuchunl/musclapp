//
//  InstructionViewController.m
//  Login
//
//  Created by Honghua Li on 2014-11-19.
//  Copyright (c) 2014 SFU. All rights reserved.
//

#import "InstructionViewController.h"
#import "InstructionDetailViewController.h"

@interface InstructionViewController (){
    
    //initial arrays
    NSMutableArray *titleArray;
    NSMutableArray *subtitleArray;
}

@end

@implementation InstructionViewController
@synthesize  tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Use the delegate method for table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //Put the exercise name into array
    titleArray = [[NSMutableArray alloc]initWithObjects:@"Wall Push Up", @"Sit Up", @"Quadruped Leg Lift", @"Push Up", @"Shoulder Bridge", @"Squat", @"T Push Up", @"Single Leg Deadlift", @"Lunge", nil] ;
    subtitleArray = [[NSMutableArray alloc]initWithObjects:@"Level 1 Arm", @"Level 1 Core", @"Level 1 Leg", @"Level 2 Arm", @"Level 2 Core", @"Level 2 Leg", @"Level 3 Arm", @"Level 3 Core", @"Level 3 Leg", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//return the number of table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//return the number of rows in the table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleArray count];
}

//Select the row with correct title
-(UITableView *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellidentifier = @"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [subtitleArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

//sent the data through identifier to next screen
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(segue.identifier);
    
    if([segue.identifier isEqualToString:@"detailSegue"]){
        NSIndexPath *indexPath = nil;
        
        InstructionDetailViewController *instructionDetail = [segue destinationViewController];
        //get the name from array
        indexPath = [tableView indexPathForSelectedRow];
        instructionDetail.titleContents = [titleArray objectAtIndex:indexPath.row];
        instructionDetail.subtitleContents = [subtitleArray objectAtIndex:indexPath.row];
        NSLog(instructionDetail.subtitleContents);
     
    }
}

@end
