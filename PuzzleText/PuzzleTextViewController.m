//
//  PuzzleTextViewController.m
//  PuzzleText
//
//  Created by Kaushik vijayaraghavan on 12/06/13.
//  Copyright (c) 2013 AIS. All rights reserved.
//

#import "PuzzleTextViewController.h"

@interface NSString (ConvertToArray)
-(NSArray *)convertToArray;
@end

@implementation NSString (ConvertToArray)

- (NSArray *)convertToArray {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSUInteger i = 0;
    while (i < self.length) {
        NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *chStr = [self substringWithRange:range];
        [arr addObject:chStr];
        i += range.length;
    }
    
    return arr;
}

@end

@interface PuzzleTextViewController ()
@property (weak, nonatomic) IBOutlet UIButton *answerCharacter;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *enteredCharacters;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *answerButtons;

@property (weak, nonatomic) IBOutlet UIButton *ec1;
@property (weak, nonatomic) IBOutlet UIButton *ec2;
@property (weak, nonatomic) IBOutlet UIButton *ec3;

@property (strong,nonatomic) NSMutableArray* firstName;

@property (strong,nonatomic) NSMutableArray* buttonList;





@end

@implementation PuzzleTextViewController

-(void) sortTheEnteredButtonCollection
{
    NSLog(@"HI"); 
    self.enteredCharacters = [self.enteredCharacters sortedArrayUsingComparator:^NSComparisonResult(id label1, id label2) {
        if ([label1 frame].origin.x > [label2 frame].origin.x) return NSOrderedDescending;
        else if ([label1 frame].origin.x < [label2 frame].origin.x) return NSOrderedAscending;
        else return NSOrderedSame;
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
 //
       
    NSMutableArray* akil = [self shuffledUpString:@"GREAME SMITH"];
    
    
    for(int i=0;i<[akil count];i++)
    {
        UIButton* myButton = [self.answerButtons objectAtIndex:i];
        [myButton setTitle:[akil objectAtIndex:i] forState:UIControlStateNormal];
    }
    
   
    
   }


-(void) viewDidAppear:(BOOL)animated
{
     [self sortTheEnteredButtonCollection];
}



-(NSMutableArray*) firstName {
    if(!_firstName) _firstName = [[NSMutableArray alloc] initWithObjects:self.ec1,self.ec2,self.ec3 , nil];
    return _firstName;
}

-(NSMutableArray*) buttonList {
    if(!_buttonList)
    {
        _buttonList = [[NSMutableArray alloc] init];
        for(int i=0;i<[self.enteredCharacters count];i++)
            [_buttonList addObject:@""];
        
    }
    return _buttonList;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)letterPressedBack:(UIButton *)sender {
    //self.editMode = YES;
    NSUInteger a = [self.enteredCharacters indexOfObject:sender];
    //self.editLocation = a;
    UIButton* b = [self.buttonList objectAtIndex:a];
    [b setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    b.hidden = NO;
    [sender setTitle:@"" forState:UIControlStateNormal];
    sender.enabled = NO;
}



- (IBAction)inputPressed:(UIButton *)sender {
   
    
  

      
    for(int i=0;i<[self.enteredCharacters count];i++ )
    {
        UIButton* a = [self.enteredCharacters objectAtIndex:i];
        //NSString* b=a.titleLabel.text;
        if(!a.isEnabled)
        {
            //self.atLocation = i;
            NSLog(@"Free %d",i);
            [a setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            a.enabled = YES;
            
            [self.buttonList replaceObjectAtIndex:i withObject:sender];
             sender.hidden = YES;
            
            break;
        }
    }
    
    
    
}


-(NSMutableArray*) shuffledUpString: (NSString*) answer 
{
    NSArray *abc = [answer convertToArray];
    
   // NSMutableArray *characterArray = [[NSMutableArray alloc]init];
    NSMutableArray *array = [abc mutableCopy];
        // character array having all characters of array
    for(int i=0;i<answer.length;i++)
    {
        NSInteger one = answer.length - i;
        NSInteger n = (arc4random() % one)+i ;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
 
    
    return array;
}

@end
