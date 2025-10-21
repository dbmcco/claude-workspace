#!/usr/bin/env node

// ABOUTME: Context-managed automation system for PAIA
// ABOUTME: Manages conversation context manually to simulate interactive sessions

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

class ContextManagedAutomation {
    constructor() {
        this.contextFile = path.join(process.env.HOME, '.claude-paia-context.json');
        this.logFile = path.join(process.env.HOME, 'Library/Logs/claude-paia-context.log');
        this.claudeCmd = '/opt/homebrew/bin/claude';
    }

    log(message) {
        const timestamp = new Date().toISOString();
        const logEntry = `${timestamp}: ${message}\n`;
        fs.appendFileSync(this.logFile, logEntry);
        console.log(logEntry.trim());
    }

    loadContext() {
        try {
            if (fs.existsSync(this.contextFile)) {
                const context = JSON.parse(fs.readFileSync(this.contextFile, 'utf8'));
                this.log(`Loaded context with ${context.exchanges.length} previous exchanges`);
                return context;
            }
        } catch (error) {
            this.log(`Error loading context: ${error.message}`);
        }
        
        return {
            sessionId: Date.now().toString(),
            created: new Date().toISOString(),
            exchanges: []
        };
    }

    saveContext(context) {
        try {
            fs.writeFileSync(this.contextFile, JSON.stringify(context, null, 2));
            this.log(`Saved context with ${context.exchanges.length} exchanges`);
        } catch (error) {
            this.log(`Error saving context: ${error.message}`);
        }
    }

    buildContextualPrompt(context, newInput) {
        let prompt = "You are continuing a previous conversation. Here's the context:\n\n";
        
        // Add previous exchanges for context
        context.exchanges.slice(-3).forEach((exchange, index) => {
            prompt += `Previous Exchange ${index + 1}:\n`;
            prompt += `Input: ${exchange.input}\n`;
            prompt += `Output: ${exchange.output}\n\n`;
        });
        
        prompt += `Current Request: ${newInput}\n\n`;
        prompt += "Please respond considering the full context above.";
        
        return prompt;
    }

    async runAutomation(input) {
        try {
            this.log(`Starting context-managed automation: ${input.substring(0, 50)}...`);
            
            // Load existing context
            const context = this.loadContext();
            
            // Build contextual prompt
            const contextualPrompt = context.exchanges.length > 0 
                ? this.buildContextualPrompt(context, input)
                : input;
            
            // Execute Claude with context
            const command = `${this.claudeCmd} --print "${contextualPrompt.replace(/"/g, '\\"')}"`;
            this.log(`Executing: ${command.substring(0, 100)}...`);
            
            const output = execSync(command, { 
                encoding: 'utf8',
                timeout: 120000, // 2 minute timeout
                cwd: '/Users/braydon/projects/claude-workspace'
            });
            
            // Save exchange to context
            context.exchanges.push({
                timestamp: new Date().toISOString(),
                input: input,
                output: output.trim()
            });
            
            this.saveContext(context);
            this.log(`Automation completed successfully`);
            
            return output;
            
        } catch (error) {
            this.log(`Automation failed: ${error.message}`);
            throw error;
        }
    }
}

// Main execution
async function main() {
    const automation = new ContextManagedAutomation();
    
    const paiaInput = "Search my vault for any @paia instructions in daily notes, analyze their context, and execute the requested actions by updating notes accordingly. Focus on today's and upcoming daily notes.";
    
    try {
        const result = await automation.runAutomation(paiaInput);
        console.log("=== AUTOMATION RESULT ===");
        console.log(result);
    } catch (error) {
        console.error("Automation failed:", error.message);
        process.exit(1);
    }
}

if (require.main === module) {
    main();
}