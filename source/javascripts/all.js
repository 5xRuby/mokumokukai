// This is where it all goes :)

(function(_) {

    var _template = "Company.new(\"{company}\") do<br />" +
                    "&nbsp;&nbsp;job \"{title}\" do<br />" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;offer \"{offer}\"<br />" +
                    "&nbsp;&nbsp;end<br />" +
                    "end";

    var _applyInfo = function(template, job) {
        return template.replace("{company}", job.company)
                       .replace("{title}", job.title)
                       .replace("{offer}", job.offer);
    }

    var Typer = function(el, sourceJobs, speed, wait) {
        var speed = speed || 50;
        var wait = wait || 2000;
        var $el = el;
        var jobs = sourceJobs || [];
        var curr = 0;

        var update = function(code) {
            if($el && $el.innerHTML) {
                $el.innerHTML = code;
            }
        }

        var updateError = function() {
            // Do nothing
        }

        var updateComplete = function() {
            curr = (curr + 1) % jobs.length;
            Rx.Observable.interval(wait).take(1).subscribe(function() { start(); });
        }

        var start = function() {
            if(jobs.size <= 0) { return; }
            var rawCode = _applyInfo(_template, jobs[curr]);
            var word$ = Rx.Observable.from(rawCode)
            var timer$ = Rx.Observable.interval(speed)

            var stringOpened = false;
            var syntaxScan = function(acc, char) {
                if(char == "\"") {
                    if(stringOpened) {
                        stringOpened = false;
                        return acc + char + "</span>";
                    } else {
                        stringOpened = true;
                        return acc + "<span class=\"job-board__highlight\">" + char;
                    }
                }
                return acc + char;
            }

            word$.zip(timer$, function(x, y) { return x; })
                .scan(syntaxScan)
                .subscribe(update, updateError, updateComplete)
        }

        return {
            start: start
        }
    }

    var setupJobBoard = function() {
        var $jobBoard = document.querySelector(".job-board");
        var $code = $jobBoard.querySelector(".job-board__code");

        var jobList = JSON.parse($jobBoard.dataset.jobs)

        var typer = new Typer($code, jobList);
        typer.start();
    }

    document.addEventListener('DOMContentLoaded', function() {
        setupJobBoard();
    });
}(window));
