import React, { useState, useEffect } from 'react';
import { ThemeContext, themes } from './contexts/ThemeContext';

export default function ThemeContextWrapper(props: { children: any; }) {
  const [theme, setTheme] = useState("light");

  function changeTheme(theme: any) {
    setTheme(theme);
  }

  useEffect(() => {
    switch (theme) {
      case themes.light:
        document.documentElement.classList.add('light');
        document.documentElement.classList.remove('dark');
        document.body.classList.add('white-content');
        break;
      case themes.dark:
      default:
        document.documentElement.classList.remove('light');
        document.documentElement.classList.add('dark');
        document.body.classList.remove('white-content');
        break;
    }
  }, [theme]);

  return (
    <ThemeContext.Provider value={{ theme: theme, changeTheme: changeTheme }}>
      {props.children}
    </ThemeContext.Provider>
  );
}