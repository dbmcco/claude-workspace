#!/usr/bin/env node

// ABOUTME: API-based PAIA automation using Claude Messages API
// ABOUTME: Proper context management for maintaining conversation state

const https = require('https');
const fs = require('fs');
const path = require('path');

class ClaudeAPIAutomation {
    constructor() {
        this.contextFile = path.join(process.env.HOME, '.claude-paia-context.json');
        this.logFile = path.join(process.env.HOME, 'Library/Logs/claude-paia-api.log');
        this.apiKey = process.env.ANTHROPIC_API_KEY; // Need API key
        this.baseUrl = 'api.anthropic.com';
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
                return JSON.parse(fs.readFileSync(this.contextFile, 'utf8'));
            }
        } catch (error) {
            this.log(`Error loading context: ${error.message}`);
        }
        
        return {
            sessionId: Date.now().toString(),
            created: new Date().toISOString(),
            messages: []
        };
    }

    saveContext(context) {
        fs.writeFileSync(this.contextFile, JSON.stringify(context, null, 2));
    }

    async callClaudeAPI(messages) {
        return new Promise((resolve, reject) => {
            if (!this.apiKey) {
                reject(new Error('ANTHROPIC_API_KEY environment variable required'));
                return;
            }

            const requestBody = JSON.stringify({
                model: "claude-3-5-sonnet-20241022",
                max_tokens: 4096,
                messages: messages,
                system: `You are a personal assistant with access to Obsidian vault functions. 
                
Available MCP functions:
- mcp__obsidian__search_notes(searchTerm, searchType)
- mcp__obsidian__get_note(notePath)
- mcp__obsidian__update_note_section(notePath, sectionHeading, newContent)
- And other Obsidian MCP functions for vault management

When you see @paia instructions in notes, analyze the context and execute the requested actions.`
            });

            const options = {
                hostname: this.baseUrl,
                path: '/v1/messages',
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'x-api-key': this.apiKey,
                    'anthropic-version': '2023-06-01'
                }
            };

            const req = https.request(options, (res) => {
                let data = '';
                res.on('data', chunk => data += chunk);
                res.on('end', () => {
                    try {
                        const response = JSON.parse(data);
                        if (response.content && response.content[0]) {
                            resolve(response.content[0].text);
                        } else {
                            reject(new Error('Invalid API response'));
                        }
                    } catch (error) {
                        reject(error);
                    }
                });
            });

            req.on('error', reject);
            req.write(requestBody);
            req.end();
        });
    }

    async runAutomation(input) {
        try {
            this.log(`Starting API-based automation`);
            
            const context = this.loadContext();
            
            // Add new user message
            context.messages.push({
                role: "user",
                content: input
            });
            
            // Call Claude API with full conversation history
            const response = await this.callClaudeAPI(context.messages);
            
            // Add assistant response to context
            context.messages.push({
                role: "assistant", 
                content: response
            });
            
            this.saveContext(context);
            this.log(`API automation completed successfully`);
            
            return response;
            
        } catch (error) {
            this.log(`API automation failed: ${error.message}`);
            throw error;
        }
    }
}

// Check for API key requirement
async function main() {
    if (!process.env.ANTHROPIC_API_KEY) {
        console.log("API-based automation requires ANTHROPIC_API_KEY");
        console.log("This approach would work but needs API access setup");
        console.log("Alternative: Work with existing Claude Code CLI limitations");
        return;
    }
    
    const automation = new ClaudeAPIAutomation();
    const paiaInput = "Search my vault for @paia instructions and execute them";
    
    try {
        const result = await automation.runAutomation(paiaInput);
        console.log("=== API AUTOMATION RESULT ===");
        console.log(result);
    } catch (error) {
        console.error("API automation failed:", error.message);
    }
}

if (require.main === module) {
    main();
}