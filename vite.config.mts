import { build, defineConfig } from 'vite';
import createReScriptPlugin from '@jihchi/vite-plugin-rescript';
import { viteSingleFile } from "vite-plugin-singlefile"

export default defineConfig({
  plugins: [createReScriptPlugin(), viteSingleFile()],
  test: {
    deps: {
      inline: true
    }
  }
});
