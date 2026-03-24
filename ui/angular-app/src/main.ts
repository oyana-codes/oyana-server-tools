import { bootstrapApplication } from '@angular/platform-browser';
import { Component, computed, signal } from '@angular/core';
import { CommonModule } from '@angular/common';

type CountdownState = {
  active: boolean;
  secondsLeft: number;
  totalSeconds: number;
  label: string;
  completed?: boolean;
};

@Component({
  selector: 'ost-root',
  standalone: true,
  imports: [CommonModule],
  template: `
    <main class="shell">
      <h1>Oyana Server Tools</h1>
      <p class="subtitle">Countdown vertical slice</p>

      <section class="card">
        <h2>{{ countdown().label }}</h2>
        <div class="value">{{ displayValue() }}</div>
        <p>
          {{ countdown().completed ? 'Countdown complete' : countdown().active ? 'Countdown active' : 'Waiting for event' }}
        </p>
      </section>

      <section class="card">
        <h2>Ready features</h2>
        <p>{{ featureText() }}</p>
      </section>
    </main>
  `,
  styles: [`
    .shell { padding: 16px; color: white; font-family: Arial, sans-serif; }
    .subtitle { color: #cbd5e1; }
    .card { margin-top: 16px; padding: 16px; border-radius: 16px; background: rgba(15,23,42,.82); }
    .value { font-size: 64px; font-weight: 800; line-height: 1; }
  `]
})
class AppComponent {
  countdown = signal<CountdownState>({ active: false, secondsLeft: 0, totalSeconds: 0, label: 'Race Start' });
  features = signal<string[]>([]);
  displayValue = computed(() => this.countdown().completed ? 'GO' : String(this.countdown().secondsLeft || 0));
  featureText = computed(() => this.features().length ? this.features().join(', ') : 'Waiting for features...');

  constructor() {
    (window as typeof window & { OST_UI?: { dispatch: (eventName: string, payload: unknown) => void } }).OST_UI = {
      dispatch: (eventName, payload) => {
        if (eventName === 'OST:UI:FeatureReady') {
          const next = new Set(this.features());
          next.add(String(payload));
          this.features.set([...next].sort());
          return;
        }

        if (eventName === 'OST:UI:CountdownState') {
          this.countdown.set(payload as CountdownState);
        }
      }
    };
  }
}

bootstrapApplication(AppComponent).catch((err) => console.error(err));
