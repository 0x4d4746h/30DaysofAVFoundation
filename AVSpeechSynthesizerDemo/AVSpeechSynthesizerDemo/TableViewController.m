//
//  TableViewController.m
//  AVSpeechSynthesizerDemo
//
//  Created by MiaoGuangfa on 3/17/16.
//  Copyright © 2016 MiaoGuangfa. All rights reserved.
//

#import "TableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TableViewCell.h"

@interface TableViewController () <AVSpeechSynthesizerDelegate>
@property (strong, nonatomic) AVSpeechSynthesizer *speechSynthesizer;
@property (strong, nonatomic) NSArray *speechStrings;
@property (strong, nonatomic) NSMutableArray *speechedStringsArray;
@property (strong, nonatomic) NSArray *voices;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 20.0f, 0.0f);
    self.speechStrings = @[@"Hello AV Foundation. How are you? My name is peter, nice to meet you~",
                           @"I'm well! Thanks for asking.",
                           @"Are you excited about the book?",
                           @"Very! I have always felt so misunderstood.",
                           @"What's your favorite feature?",
                           @"Oh, they're all my babies.  I couldn't possibly choose.",
                           @"It was great to speak with you!",
                           @"The pleasure was all mine!  Have fun!",
                           @"The pleasure was all mine!  Have fun!",
                           @"The pleasure was all mine!  Have fun!",
                           @"The pleasure was all mine!  Have fun!",
                           @"The pleasure was all mine!  Have fun!",
                           @"The pleasure was all mine!  Have fun!"];
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc]init];
    self.speechSynthesizer.delegate = self;
    
    _voices = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
                [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"]];
    
    self.speechedStringsArray = [NSMutableArray new];
    
    [self beginSpeech];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) beginSpeech {
    for (NSUInteger i =0; i< self.speechStrings.count; i++) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:self.speechStrings[i]];
        utterance.voice = _voices[i%2];
        utterance.rate = 0.5f;
        utterance.pitchMultiplier = 0.8f;
        utterance.postUtteranceDelay = 0.1f;
        [self.speechSynthesizer speakUtterance:utterance];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.speechedStringsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = indexPath.row % 2 == 0 ? @"YouCell" : @"AVCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.messageLabel.text = self.speechedStringsArray[indexPath.row];
    
    return cell;
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(nonnull AVSpeechUtterance *)utterance {
    [self.speechedStringsArray addObject:utterance.speechString];
    [self.tableView reloadData];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.speechedStringsArray.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
