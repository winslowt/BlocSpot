//
//  Animator.m
//  BlocSpot
//
//  Created by Tony  Winslow on 5/8/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "Animator.h"

//@implementation Animator
//
//- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
//{
//    return 0.25;
//}

//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    [[transitionContext containerView] addSubview:toViewController.view];
//    toViewController.view.alpha = 0;
//    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        toViewController.view.alpha = 1;
//    } completion:^(BOOL finished) {
//        fromViewController.view.transform = CGAffineTransformIdentity;
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        
//    }];
//    
//    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
//    
//}
//- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController
//                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
//{
//    return self.interactionController;
//}
//
//
//
//    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
//    if (location.x >  CGRectGetMidX(view.bounds)) {
//        navigationControllerDelegate.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
//        [self performSegueWithIdentifier:PushSegueIdentifier sender:self];
//    }
//}
//
//
//
//@end
