//
//  cf_run_loop_core.c
//  RunLoop
//
//  Created by Jentle on 2019/10/2.
//  Copyright © 2019 Jentle. All rights reserved.
//

#include "cf_run_loop_core.h"


void CFRunLoopRun(void) {    /* DOES CALLOUT */
    int32_t result;
    do {
        result = CFRunLoopRunSpecific(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, 1.0e10, false);
        CHECK_FOR_FORK();
    } while (kCFRunLoopRunStopped != result && kCFRunLoopRunFinished != result);
}

SInt32 CFRunLoopRunSpecific(CFRunLoopRef rl, CFStringRef modeName, CFTimeInterval seconds, Boolean returnAfterSourceHandled) {     /* DOES CALLOUT */
//    CHECK_FOR_FORK();
//    if (__CFRunLoopIsDeallocating(rl)) return kCFRunLoopRunFinished;
//    __CFRunLoopLock(rl);
//    CFRunLoopModeRef currentMode = __CFRunLoopFindMode(rl, modeName, false);
//    if (NULL == currentMode || __CFRunLoopModeIsEmpty(rl, currentMode, rl->_currentMode)) {
//        Boolean did = false;
//        if (currentMode) __CFRunLoopModeUnlock(currentMode);
//        __CFRunLoopUnlock(rl);
//        return did ? kCFRunLoopRunHandledSource : kCFRunLoopRunFinished;
//    }
//    volatile _per_run_data *previousPerRun = __CFRunLoopPushPerRunData(rl);
//    CFRunLoopModeRef previousMode = rl->_currentMode;
//    rl->_currentMode = currentMode;
//    int32_t result = kCFRunLoopRunFinished;
    
//    if (currentMode->_observerMask & kCFRunLoopEntry )
    ///通知observer:进入Loop
        __CFRunLoopDoObservers(rl, currentMode, kCFRunLoopEntry);
    ///loop的核心逻辑
    result = __CFRunLoopRun(rl, currentMode, seconds, returnAfterSourceHandled, previousMode);
//    if (currentMode->_observerMask & kCFRunLoopExit )
    ///通知observer:退出Loop
        __CFRunLoopDoObservers(rl, currentMode, kCFRunLoopExit);
    
//    __CFRunLoopModeUnlock(currentMode);
//    __CFRunLoopPopPerRunData(rl, previousPerRun);
//    rl->_currentMode = previousMode;
//    __CFRunLoopUnlock(rl);
    return result;
}

/* rl, rlm are locked on entrance and exit */
static int32_t __CFRunLoopRun(CFRunLoopRef rl, CFRunLoopModeRef rlm, CFTimeInterval seconds, Boolean stopAfterHandle, CFRunLoopModeRef previousMode) {
//    uint64_t startTSR = mach_absolute_time();
//
//    if (__CFRunLoopIsStopped(rl)) {
//        __CFRunLoopUnsetStopped(rl);
//        return kCFRunLoopRunStopped;
//    } else if (rlm->_stopped) {
//        rlm->_stopped = false;
//        return kCFRunLoopRunStopped;
//    }
//
//    mach_port_name_t dispatchPort = MACH_PORT_NULL;
//    Boolean libdispatchQSafe = pthread_main_np() && ((HANDLE_DISPATCH_ON_BASE_INVOCATION_ONLY && NULL == previousMode) || (!HANDLE_DISPATCH_ON_BASE_INVOCATION_ONLY && 0 == _CFGetTSD(__CFTSDKeyIsInGCDMainQ)));
//    if (libdispatchQSafe && (CFRunLoopGetMain() == rl) && CFSetContainsValue(rl->_commonModes, rlm->_name)) dispatchPort = _dispatch_get_main_queue_port_4CF();
//
//#if USE_DISPATCH_SOURCE_FOR_TIMERS
//    mach_port_name_t modeQueuePort = MACH_PORT_NULL;
//    if (rlm->_queue) {
//        modeQueuePort = _dispatch_runloop_root_queue_get_port_4CF(rlm->_queue);
//        if (!modeQueuePort) {
//            CRASH("Unable to get port for run loop mode queue (%d)", -1);
//        }
//    }
//#endif
//
//    dispatch_source_t timeout_timer = NULL;
//    struct __timeout_context *timeout_context = (struct __timeout_context *)malloc(sizeof(*timeout_context));
//    if (seconds <= 0.0) { // instant timeout
//        seconds = 0.0;
//        timeout_context->termTSR = 0ULL;
//    } else if (seconds <= TIMER_INTERVAL_LIMIT) {
//        dispatch_queue_t queue = pthread_main_np() ? __CFDispatchQueueGetGenericMatchingMain() : __CFDispatchQueueGetGenericBackground();
//        timeout_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//        dispatch_retain(timeout_timer);
//        timeout_context->ds = timeout_timer;
//        timeout_context->rl = (CFRunLoopRef)CFRetain(rl);
//        timeout_context->termTSR = startTSR + __CFTimeIntervalToTSR(seconds);
//        dispatch_set_context(timeout_timer, timeout_context); // source gets ownership of context
//        dispatch_source_set_event_handler_f(timeout_timer, __CFRunLoopTimeout);
//        dispatch_source_set_cancel_handler_f(timeout_timer, __CFRunLoopTimeoutCancel);
//        uint64_t ns_at = (uint64_t)((__CFTSRToTimeInterval(startTSR) + seconds) * 1000000000ULL);
//        dispatch_source_set_timer(timeout_timer, dispatch_time(1, ns_at), DISPATCH_TIME_FOREVER, 1000ULL);
//        dispatch_resume(timeout_timer);
//    } else { // infinite timeout
//        seconds = 9999999999.0;
//        timeout_context->termTSR = UINT64_MAX;
//    }
//
//    Boolean didDispatchPortLastTime = true;
    int32_t retVal = 0;
    do {
        
//        if (rlm->_observerMask & kCFRunLoopBeforeTimers)
        ///通知observer:即将处理Timers
        __CFRunLoopDoObservers(rl, rlm, kCFRunLoopBeforeTimers);
//        if (rlm->_observerMask & kCFRunLoopBeforeSources)
        ///通知observer:即将处理sources
        __CFRunLoopDoObservers(rl, rlm, kCFRunLoopBeforeSources);
        ///通知observer:处理block
        __CFRunLoopDoBlocks(rl, rlm);
        
//        Boolean sourceHandledThisLoop =
        ///处理source0
        __CFRunLoopDoSources0(rl, rlm, stopAfterHandle);
//        if (sourceHandledThisLoop) {
        ///处理blocks
        __CFRunLoopDoBlocks(rl, rlm);
//        }
        
        Boolean poll = sourceHandledThisLoop || (0ULL == timeout_context->termTSR);
        
//        if (MACH_PORT_NULL != dispatchPort && !didDispatchPortLastTime) {
//#if DEPLOYMENT_TARGET_MACOSX || DEPLOYMENT_TARGET_EMBEDDED || DEPLOYMENT_TARGET_EMBEDDED_MINI
//            msg = (mach_msg_header_t *)msg_buffer;
            ///如果有source1(port相关的是source1)，就跳转到handle_msg标记处
            if (__CFRunLoopServiceMachPort(dispatchPort, &msg, sizeof(msg_buffer), &livePort, 0, &voucherState, NULL)) {
                goto handle_msg;
            }
//        }
        
        didDispatchPortLastTime = false;
        
        if (!poll && (rlm->_observerMask & kCFRunLoopBeforeWaiting))
            ///通知observers:即将休眠
            __CFRunLoopDoObservers(rl, rlm, kCFRunLoopBeforeWaiting);
         ///休眠
         __CFRunLoopSetSleeping(rl);
        // do not do any user callouts after this point (after notifying of sleeping)
        
        // Must push the local-to-this-activation ports in on every loop
        // iteration, as this mode could be run re-entrantly and we don't
        // want these ports to get serviced.
        
        __CFPortSetInsert(dispatchPort, waitSet);
        
//        __CFRunLoopModeUnlock(rlm);
//        __CFRunLoopUnlock(rl);
        
        CFAbsoluteTime sleepStart = poll ? 0.0 : CFAbsoluteTimeGetCurrent();
        
#if DEPLOYMENT_TARGET_MACOSX || DEPLOYMENT_TARGET_EMBEDDED || DEPLOYMENT_TARGET_EMBEDDED_MINI
#if USE_DISPATCH_SOURCE_FOR_TIMERS
        
        ///进入休眠，等待其他消息唤醒
        do {
            if (kCFUseCollectableAllocator) {
                // objc_clear_stack(0);
                // <rdar://problem/16393959>
                memset(msg_buffer, 0, sizeof(msg_buffer));
            }
            msg = (mach_msg_header_t *)msg_buffer;
            ///等待别的消息来唤醒当前线程
            __CFRunLoopServiceMachPort(waitSet, &msg, sizeof(msg_buffer), &livePort, poll ? 0 : TIMEOUT_INFINITY, &voucherState, &voucherCopy);
            
            if (modeQueuePort != MACH_PORT_NULL && livePort == modeQueuePort) {
                // Drain the internal queue. If one of the callout blocks sets the timerFired flag, break out and service the timer.
                while (_dispatch_runloop_root_queue_perform_4CF(rlm->_queue));
                if (rlm->_timerFired) {
                    // Leave livePort as the queue port, and service timers below
                    rlm->_timerFired = false;
                    break;
                } else {
                    if (msg && msg != (mach_msg_header_t *)msg_buffer) free(msg);
                }
            } else {
                // Go ahead and leave the inner loop.
                break;
            }
        } while (1);
#else
        if (kCFUseCollectableAllocator) {
            // objc_clear_stack(0);
            // <rdar://problem/16393959>
            memset(msg_buffer, 0, sizeof(msg_buffer));
        }
        msg = (mach_msg_header_t *)msg_buffer;
        __CFRunLoopServiceMachPort(waitSet, &msg, sizeof(msg_buffer), &livePort, poll ? 0 : TIMEOUT_INFINITY, &voucherState, &voucherCopy);
#endif
        
        __CFRunLoopLock(rl);
        __CFRunLoopModeLock(rlm);
        
        rl->_sleepTime += (poll ? 0.0 : (CFAbsoluteTimeGetCurrent() - sleepStart));
        
        // Must remove the local-to-this-activation ports in on every loop
        // iteration, as this mode could be run re-entrantly and we don't
        // want these ports to get serviced. Also, we don't want them left
        // in there if this function returns.
        
        __CFPortSetRemove(dispatchPort, waitSet);
        
        __CFRunLoopSetIgnoreWakeUps(rl);
        
        // user callouts now OK again
        __CFRunLoopUnsetSleeping(rl);
        if (!poll && (rlm->_observerMask & kCFRunLoopAfterWaiting))
            ///通知observers:结束休眠
            __CFRunLoopDoObservers(rl, rlm, kCFRunLoopAfterWaiting);
        
    handle_msg:
        __CFRunLoopSetIgnoreWakeUps(rl);
        
//        if (MACH_PORT_NULL == livePort) {
//            CFRUNLOOP_WAKEUP_FOR_NOTHING();
//            // handle nothing
//        } else
            
//       if (livePort == rl->_wakeUpPort) {
//            CFRUNLOOP_WAKEUP_FOR_WAKEUP();
//            // do nothing on Mac OS
//        }
#if USE_DISPATCH_SOURCE_FOR_TIMERS
        else if (modeQueuePort != MACH_PORT_NULL && livePort == modeQueuePort) {
            CFRUNLOOP_WAKEUP_FOR_TIMER();
            if (!__CFRunLoopDoTimers(rl, rlm, mach_absolute_time())) {
                // Re-arm the next timer, because we apparently fired early
                __CFArmNextTimerInMode(rlm, rl);
            }
        }
#endif
#if USE_MK_TIMER_TOO
        else if (rlm->_timerPort != MACH_PORT_NULL && livePort == rlm->_timerPort) {
            CFRUNLOOP_WAKEUP_FOR_TIMER();
            // On Windows, we have observed an issue where the timer port is set before the time which we requested it to be set. For example, we set the fire time to be TSR 167646765860, but it is actually observed firing at TSR 167646764145, which is 1715 ticks early. The result is that, when __CFRunLoopDoTimers checks to see if any of the run loop timers should be firing, it appears to be 'too early' for the next timer, and no timers are handled.
            // In this case, the timer port has been automatically reset (since it was returned from MsgWaitForMultipleObjectsEx), and if we do not re-arm it, then no timers will ever be serviced again unless something adjusts the timer list (e.g. adding or removing timers). The fix for the issue is to reset the timer here if CFRunLoopDoTimers did not handle a timer itself. 9308754
            if (!__CFRunLoopDoTimers(rl, rlm, mach_absolute_time())) {
                // Re-arm the next timer
                __CFArmNextTimerInMode(rlm, rl);
            }
        }
#endif
        else if (livePort == dispatchPort) {
            CFRUNLOOP_WAKEUP_FOR_DISPATCH();
            __CFRunLoopModeUnlock(rlm);
            __CFRunLoopUnlock(rl);
            _CFSetTSD(__CFTSDKeyIsInGCDMainQ, (void *)6, NULL);
            
            __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__(msg);
            _CFSetTSD(__CFTSDKeyIsInGCDMainQ, (void *)0, NULL);
            __CFRunLoopLock(rl);
            __CFRunLoopModeLock(rlm);
            sourceHandledThisLoop = true;
            didDispatchPortLastTime = true;
        } else {
            CFRUNLOOP_WAKEUP_FOR_SOURCE();
            
            // If we received a voucher from this mach_msg, then put a copy of the new voucher into TSD. CFMachPortBoost will look in the TSD for the voucher. By using the value in the TSD we tie the CFMachPortBoost to this received mach_msg explicitly without a chance for anything in between the two pieces of code to set the voucher again.
            voucher_t previousVoucher = _CFSetTSD(__CFTSDKeyMachMessageHasVoucher, (void *)voucherCopy, os_release);
            
            // Despite the name, this works for windows handles as well
            CFRunLoopSourceRef rls = __CFRunLoopModeFindSourceForMachPort(rl, rlm, livePort);
            if (rls) {
#if DEPLOYMENT_TARGET_MACOSX || DEPLOYMENT_TARGET_EMBEDDED || DEPLOYMENT_TARGET_EMBEDDED_MINI
                mach_msg_header_t *reply = NULL;
                sourceHandledThisLoop = __CFRunLoopDoSource1(rl, rlm, rls, msg, msg->msgh_size, &reply) || sourceHandledThisLoop;
                if (NULL != reply) {
                    (void)mach_msg(reply, MACH_SEND_MSG, reply->msgh_size, 0, MACH_PORT_NULL, 0, MACH_PORT_NULL);
                    CFAllocatorDeallocate(kCFAllocatorSystemDefault, reply);
                }
     }
            
            // Restore the previous voucher
            _CFSetTSD(__CFTSDKeyMachMessageHasVoucher, previousVoucher, os_release);
            
        }
#if DEPLOYMENT_TARGET_MACOSX || DEPLOYMENT_TARGET_EMBEDDED || DEPLOYMENT_TARGET_EMBEDDED_MINI
        if (msg && msg != (mach_msg_header_t *)msg_buffer) free(msg);
#endif
        
        __CFRunLoopDoBlocks(rl, rlm);
        
        
        if (sourceHandledThisLoop && stopAfterHandle) {
            retVal = kCFRunLoopRunHandledSource;
        } else if (timeout_context->termTSR < mach_absolute_time()) {
            retVal = kCFRunLoopRunTimedOut;
        } else if (__CFRunLoopIsStopped(rl)) {
            __CFRunLoopUnsetStopped(rl);
            retVal = kCFRunLoopRunStopped;
        } else if (rlm->_stopped) {
            rlm->_stopped = false;
            retVal = kCFRunLoopRunStopped;
        } else if (__CFRunLoopModeIsEmpty(rl, rlm, previousMode)) {
            retVal = kCFRunLoopRunFinished;
        }
        
#if DEPLOYMENT_TARGET_MACOSX || DEPLOYMENT_TARGET_EMBEDDED || DEPLOYMENT_TARGET_EMBEDDED_MINI
        voucher_mach_msg_revert(voucherState);
        os_release(voucherCopy);
#endif
        
    } while (0 == retVal);
    
    if (timeout_timer) {
        dispatch_source_cancel(timeout_timer);
        dispatch_release(timeout_timer);
    } else {
        free(timeout_context);
    }
    
    return retVal;
}

