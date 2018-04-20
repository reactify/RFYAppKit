//
//  RFYAudioUtils.c
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 15/04/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import <Accelerate/Accelerate.h>
#import "RFYAudioUtils.h"

AudioStreamBasicDescription nonInterleavedFloatStereo() {
  AudioStreamBasicDescription audioDescription;
  memset(&audioDescription, 0, sizeof(audioDescription));
  audioDescription.mFormatID          = kAudioFormatLinearPCM;
  audioDescription.mFormatFlags       = kAudioFormatFlagIsFloat | kAudioFormatFlagIsPacked | kAudioFormatFlagIsNonInterleaved;
  audioDescription.mChannelsPerFrame  = 2;
  audioDescription.mBytesPerPacket    = sizeof(float);
  audioDescription.mFramesPerPacket   = 1;
  audioDescription.mBytesPerFrame     = sizeof(float);
  audioDescription.mBitsPerChannel    = 8 * sizeof(float);
  audioDescription.mSampleRate        = 44100.0;
  return audioDescription;
}

AudioBufferList *InitAudioBufferList(AudioStreamBasicDescription audioFormat, int frameCount) {
  int numberOfBuffers = audioFormat.mFormatFlags & kAudioFormatFlagIsNonInterleaved ? audioFormat.mChannelsPerFrame : 1;
  int channelsPerBuffer = audioFormat.mFormatFlags & kAudioFormatFlagIsNonInterleaved ? 1 : audioFormat.mChannelsPerFrame;
  int bytesPerBuffer = audioFormat.mBytesPerFrame * frameCount;
  
  let audio = (AudioBufferList *)malloc(sizeof(AudioBufferList) + (numberOfBuffers-1)*sizeof(AudioBuffer));
  if ( !audio ) return NULL;
  
  audio->mNumberBuffers = numberOfBuffers;
  for ( int i=0; i<numberOfBuffers; i++ ) {
    if ( bytesPerBuffer > 0 ) {
      audio->mBuffers[i].mData = calloc(bytesPerBuffer, 1);
      if ( !audio->mBuffers[i].mData ) {
        for ( int j=0; j<i; j++ ) free(audio->mBuffers[j].mData);
        free(audio);
        return NULL;
      }
    } else {
      audio->mBuffers[i].mData = NULL;
    }
    audio->mBuffers[i].mDataByteSize = bytesPerBuffer;
    audio->mBuffers[i].mNumberChannels = channelsPerBuffer;
  }
  return audio;
}

void FreeAudioBufferList(AudioBufferList *bufferList) {
  for ( int i=0; i<bufferList->mNumberBuffers; i++ ) {
    if ( bufferList->mBuffers[i].mData ) free(bufferList->mBuffers[i].mData);
  }
  free(bufferList);
}

void ClearAudioBufferList(AudioBufferList *bufferList, const int frames) {
  for ( int i = 0; i < bufferList->mNumberBuffers; i++ ) {
    vDSP_vclr((float *)bufferList->mBuffers[i].mData, 1, frames);
  }
}
