#!/usr/bin/env node

// ABOUTME: Hybrid PAIA automation - Claude API + local MCP function calls
// ABOUTME: Best of both worlds: API context management + MCP function access

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

class HybridPAIAAutomation {
    constructor() {
        this.contextFile = path.join(process.env.HOME, '.claude-paia-hybrid-context.json');
        this.logFile = path.join(process.env.HOME, 'Library/Logs/claude-paia-hybrid.log');
        this.claudeCmd = '/opt/homebrew/bin/claude';
        this.apiKey = process.env.ANTHROPIC_API_KEY;
    }

    log(message) {
        const timestamp = new Date().toISOString();
        const logEntry = `${timestamp}: ${message}\n`;
        fs.appendFileSync(this.logFile, logEntry);
        console.log(logEntry.trim());
    }

    // Execute MCP functions through Claude Code CLI
    executeMCPFunction(functionCall) {
        try {
            this.log(`Executing MCP function: ${functionCall}`);
            const prompt = `Execute this MCP function and return only the result: ${functionCall}`;
            const result = execSync(`${this.claudeCmd} --continue --print "${prompt}"`, {
                encoding: 'utf8',
                timeout: 30000,
                cwd: '/Users/braydon/projects/claude-workspace'
            });
            return result.trim();
        } catch (error) {
            this.log(`MCP function error: ${error.message}`);
            return `Error executing ${functionCall}: ${error.message}`;
        }
    }

    // Search for @paia instructions
    searchPaiaInstructions() {
        try {
            const searchResult = this.executeMCPFunction('mcp__obsidian__search_notes("@paia", "content")');
            return searchResult;
        } catch (error) {
            this.log(`Error searching @paia: ${error.message}`);
            return null;
        }
    }

    // Process found @paia instructions
    processPaiaInstructions() {
        this.log("Starting hybrid PAIA automation...");
        
        // Step 1: Search for @paia instructions using MCP
        const searchResult = this.searchPaiaInstructions();
        
        if (!searchResult || searchResult.includes('Error')) {
            this.log("No @paia instructions found or search failed");
            return "No @paia instructions found or search failed";
        }

        this.log("Found @paia instructions, processing...");

        // Step 2: Use Claude Code with context to analyze and execute
        const analysisPrompt = `Found @paia instructions in vault. Based on the search results below, analyze each @paia instruction and execute the requested actions:

Search Results:
${searchResult}

For each @paia instruction found:
1. Read the full context of the note containing the instruction
2. Understand what action is being requested  
3. Execute the action using appropriate MCP functions
4. Mark the @paia instruction as completed

Please process all @paia instructions found.`;

        try {
            const result = execSync(`${this.claudeCmd} --continue --print "${analysisPrompt.replace(/"/g, '\\"')}"`, {
                encoding: 'utf8',
                timeout: 120000, // 2 minutes
                cwd: '/Users/braydon/projects/claude-workspace'
            });

            this.log("PAIA instructions processed successfully");
            return result;

        } catch (error) {
            this.log(`Error processing PAIA instructions: ${error.message}`);
            return `Error processing PAIA instructions: ${error.message}`;
        }
    }
}

// Main execution
async function main() {
    const automation = new HybridPAIAAutomation();
    
    try {
        const result = automation.processPaiaInstructions();
        console.log("\n=== HYBRID PAIA AUTOMATION RESULT ===");
        console.log(result);
    } catch (error) {
        console.error("Hybrid automation failed:", error.message);
        process.exit(1);
    }
}

if (require.main === module) {
    main();
}