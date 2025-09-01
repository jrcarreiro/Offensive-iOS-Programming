import Foundation
import Darwin

func executeCommand(_ shellPath: UnsafePointer<CChar>?, _ command: UnsafePointer<CChar>?) -> String {
    guard let sp = shellPath, let cmd = command else { return "invalid arguments" }

    var pid: pid_t = 0

    var pipefd: [Int32] = [0, 0]
    if pipe(&pipefd) != 0 {
        return "pipe() failed: \(errno)"
    }

    var actions: posix_spawn_file_actions_t?
    posix_spawn_file_actions_init(&actions)
    posix_spawn_file_actions_addclose(&actions, pipefd[0])
    posix_spawn_file_actions_adddup2(&actions, pipefd[1], STDOUT_FILENO)
    posix_spawn_file_actions_adddup2(&actions, pipefd[1], STDERR_FILENO)
    posix_spawn_file_actions_addclose(&actions, pipefd[1])

    // argv: ["sh", "-c", <command>, nil]
    let arg0 = strdup("sh")
    let arg1 = strdup("-c")
    let arg2 = UnsafeMutablePointer<CChar>(mutating: cmd)
    var argv: [UnsafeMutablePointer<CChar>?] = [arg0, arg1, arg2, nil]

    // spawn
    let spawnResult: Int32 = withUnsafePointer(to: sp) { spPtr in
        posix_spawn(&pid, sp, &actions, nil, &argv, environ)
    }

    if let a0 = arg0 { free(a0) }
    if let a1 = arg1 { free(a1) }
    posix_spawn_file_actions_destroy(&actions)
    close(pipefd[1])

    guard spawnResult == 0 else {
        close(pipefd[0])
        return "posix_spawn failed: \(spawnResult)"
    }

    var output = Data()
    var buffer = [UInt8](repeating: 0, count: 4096)
    while true {
        let count = read(pipefd[0], &buffer, buffer.count)
        if count > 0 {
            output.append(buffer, count: count)
        } else {
            break
        }
    }
    close(pipefd[0])

    var status: Int32 = 0
    waitpid(pid, &status, 0)

    return String(data: output, encoding: .utf8) ?? ""
}

