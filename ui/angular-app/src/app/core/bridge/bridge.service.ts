import { Injectable, signal } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class BridgeService {
  private readonly bridgeStatus = signal('disconnected');

  constructor() {
    this.bridgeStatus.set('ready');
  }

  status() {
    return this.bridgeStatus();
  }

  dispatch(eventName: string, payload?: unknown) {
    console.log('[OST bridge]', eventName, payload);
  }
}
