import { Injectable, signal } from '@angular/core';
import type { ToolState } from '../models/tool-state.model';

@Injectable({ providedIn: 'root' })
export class ToolStateService {
  readonly tools = signal<ToolState[]>([
    { name: 'countdown', enabled: true },
    { name: 'flood', enabled: true },
    { name: 'map', enabled: true },
    { name: 'admin', enabled: true }
  ]);
}
