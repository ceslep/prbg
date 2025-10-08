import { writable } from 'svelte/store';

const mediaQuery = typeof window !== 'undefined' ? window.matchMedia('(prefers-color-scheme: light)') : null;

function createThemeStore() {
    const { subscribe, set, update } = writable<'light' | 'dark'>('dark'); // Default to dark

    if (typeof window !== 'undefined') {
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme === 'light' || savedTheme === 'dark') {
            set(savedTheme);
        } else if (mediaQuery && mediaQuery.matches) {
            set('light');
        }

        // Listen for changes in system preference
        mediaQuery?.addEventListener('change', (e) => {
            set(e.matches ? 'light' : 'dark');
        });
    }

    return {
        subscribe,
        set: (value: 'light' | 'dark') => {
            localStorage.setItem('theme', value);
            set(value);
        },
        toggle: () => {
            update(currentTheme => {
                const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
                localStorage.setItem('theme', newTheme);
                return newTheme;
            });
        }
    };
}

export const theme = createThemeStore();

// Apply the theme class to the document element whenever the store changes
theme.subscribe(currentTheme => {
    if (typeof document !== 'undefined') {
        if (currentTheme === 'dark') {
            document.documentElement.classList.add('dark');
        } else {
            document.documentElement.classList.remove('dark');
        }
    }
});
